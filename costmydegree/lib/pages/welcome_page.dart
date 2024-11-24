import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5BA3F8),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 10,
            child: Image.asset(
              'assets/images/grad.png',
            ),
          ),
          const Positioned(
            top: 550,
            child: Text(
              "Welcome to CostMyDegree",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const Positioned(
            top: 600, // Adjust this value to position text
            child: Text(
              "Your Path to Smarter Education Choices!",
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            bottom: -75,
            child: Image.asset(
              'assets/images/dots.png',
              height: 500,
              width: 600,
            ),
          ),
          Positioned(
            bottom: 65,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/quiz');
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                backgroundColor: Colors.black, // Button background color
                foregroundColor: Colors.white, // Button text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Rounded edges
                ),
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
