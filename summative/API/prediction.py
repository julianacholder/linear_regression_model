from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import pickle
import pandas as pd
import uvicorn

# Create FastAPI app
app = FastAPI(
    title="Tuition Fee Prediction API",
     description="""
    This API predicts university tuition fees based on various factors.
    
    ## Input Features
    * Country: The country of the university
    * Course Type: The field of study
    * University Type: Public or Private institution
    * Mode of Study: Full-time or Online
    
    ## How to use
    1. Use the POST /predict endpoint
    2. Provide all required input parameters
    3. Get the predicted tuition fee in USD
    """,
    version="1.0.0"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

# Define input data model with constraints
class TuitionRequest(BaseModel):
    country: str = Field(
        ..., 
        description="Country name (must be uppercase)",
        example="USA"
    )
    course_type: str = Field(
        ..., 
        description="Type of course",
        example="Computer Science"
    )
    univ_type: str = Field(
        ..., 
        description="University type (Public/Private)",
        example="Public"
    )
    mode_of_study: str = Field(
        ..., 
        description="Mode of study (Full-time/Online)",
        example="Full-time"
    )

# Define response model
class TuitionResponse(BaseModel):
    predicted_fee: float = Field(..., description="Predicted tuition fee in USD")
    currency: str = "USD"

# Load the saved model and preprocessors
try:
    with open('models/best_model.pkl', 'rb') as file:
        model = pickle.load(file)
    
    with open('models/scaler.pkl', 'rb') as file:
        scaler = pickle.load(file)
        
    with open('models/encoders_and_mappings.pkl', 'rb') as file:
        encoders_and_mappings = pickle.load(file)
        
    le_country_mapping = encoders_and_mappings['le_country_mapping']
    le_course_mapping = encoders_and_mappings['le_course_mapping']
    le_univ_type_mapping = encoders_and_mappings['le_univ_type_mapping']
    le_mode_mapping = encoders_and_mappings['le_mode_mapping']
except Exception as e:
    print(f"Error loading model files: {str(e)}")

@app.get("/")
def read_root():
    return {"message": "Welcome to the Tuition Fee Prediction API"}

@app.post("/predict", response_model=TuitionResponse)
def predict_tuition(request: TuitionRequest):
    try:
        # Convert country to uppercase
        country = request.country.upper()
        
        # Validate inputs
        if country not in le_country_mapping:
            raise HTTPException(
                status_code=400,
                detail=f"Invalid country. Available options: {list(le_country_mapping.keys())}"
            )
        if request.course_type not in le_course_mapping:
            raise HTTPException(
                status_code=400,
                detail=f"Invalid course type. Available options: {list(le_course_mapping.keys())}"
            )
        if request.univ_type not in le_univ_type_mapping:
            raise HTTPException(
                status_code=400,
                detail=f"Invalid university type. Available options: {list(le_univ_type_mapping.keys())}"
            )
        if request.mode_of_study not in le_mode_mapping:
            raise HTTPException(
                status_code=400,
                detail=f"Invalid mode of study. Available options: {list(le_mode_mapping.keys())}"
            )

        # Encode inputs
        country_encoded = le_country_mapping[country]
        course_encoded = le_course_mapping[request.course_type]
        univ_encoded = le_univ_type_mapping[request.univ_type]
        mode_encoded = le_mode_mapping[request.mode_of_study]

        # Create feature array
        features = pd.DataFrame(
            [[country_encoded, course_encoded, univ_encoded, mode_encoded]],
            columns=['Country', 'Course', 'University Type', 'Mode of Study']
        )

        # Scale features
        features_scaled = scaler.transform(features)

        # Make prediction
        prediction = model.predict(features_scaled)[0]

        formatted_fee = f"${prediction:,.0f}"

        # Return the response
        return TuitionResponse(predicted_fee=formatted_fee)

    except HTTPException as e:
        raise e
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/options")
def get_available_options():
    """Get available options for all input fields"""
    return {
        "countries": list(le_country_mapping.keys()),
        "course_types": list(le_course_mapping.keys()),
        "university_types": list(le_univ_type_mapping.keys()),
        "study_modes": list(le_mode_mapping.keys())
    }

if __name__ == "__main__":
    uvicorn.run("prediction:app", host="0.0.0.0", port=8000, reload=True)