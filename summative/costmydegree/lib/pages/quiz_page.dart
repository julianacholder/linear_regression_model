import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 120.0, left: 20, right: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                "Predict Tuition Fees",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                textAlign: TextAlign.center,
                "Discover and compare tuition fees for some of the most sought-after master's programs across top study destinations. Find the perfect fit for your academic journey and budget!",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Country',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                          decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(5), // Rounded corners
                        ),
                      ))),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Degree',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                          decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(5), // Rounded corners
                        ),
                      ))),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Course Specialization',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                          decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(5), // Rounded corners
                        ),
                      ))),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Mode of study',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                          decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(5), // Rounded corners
                        ),
                      )))
                ],
              )),
              SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/result');
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  backgroundColor: Color(0xFF5BA3F8), // Button background color
                  foregroundColor: Colors.white, // Button text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Rounded edges
                  ),
                ),
                child: const Text(
                  "Predict",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
