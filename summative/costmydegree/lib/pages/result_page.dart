import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the prediction results passed as arguments
    final Map<String, dynamic> predictionResult =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    // Extract values from the prediction result
    final String country = predictionResult['country'] ?? 'Unknown Country';
    final String courseType =
        predictionResult['course_type'] ?? 'Unknown Course';
    final String predictedFee =
        predictionResult['predicted_fee']?.toString() ?? 'N/A';

    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        const Positioned(
            top: 130,
            child: Text(
              "Predicted Study Cost",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        Positioned(top: 115, child: Image.asset('assets/images/hat.png')),
        Positioned(
            top: 385,
            child: Text(
              'Masters of $courseType ($country)',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        Positioned(
            top: 450,
            left: 30,
            child: Row(
              children: [
                const Text("Predicted Tuition Fees:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                const SizedBox(width: 10),
                Text(predictedFee,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w900))
              ],
            )),
        const Positioned(
            top: 495,
            child: Text(
                "(Based on average tuition fees for this course and country)",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
        Positioned(
          bottom: 210,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/quiz');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              "Retake Quiz",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
