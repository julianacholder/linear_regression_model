import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        const Positioned(
            top: 385,
            child: Text(
              'M.Sc in Data Science (Germany)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        const Positioned(
            top: 450,
            left: 30,
            child: Row(
              children: [
                Text("Predicted Tuition Fees:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                SizedBox(
                  width: 10,
                ),
                Text('21,900',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900))
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
              Navigator.pushNamed(context, '/quiz');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              backgroundColor: Colors.black, // Button background color
              foregroundColor: Colors.white, // Button text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Rounded edges
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
