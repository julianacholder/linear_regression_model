import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _countryController = TextEditingController();
  final _universityTypeController = TextEditingController();
  final _courseSpecializationController = TextEditingController();
  final _modeOfStudyController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http.post(
          Uri.parse('https://predict-tuition.onrender.com/predict'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'country': _countryController.text,
            'univ_type': _universityTypeController.text,
            'course_type': _courseSpecializationController.text,
            'mode_of_study': _modeOfStudyController.text,
          }),
        );

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);

          result['country'] = _countryController.text;
          result['course_type'] = _courseSpecializationController.text;

          Navigator.pushNamed(
            context,
            '/result',
            arguments: result,
          );
        } else {
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to get prediction. Please try again.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('An error occurred. Please check your connection.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _countryController.dispose();
    _universityTypeController.dispose();
    _courseSpecializationController.dispose();
    _modeOfStudyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 17, right: 17),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Predict Tuition Fees",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                const Text(
                  "Discover and compare tuition fees for some of the most sought-after master's programs across top study destinations!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  "(Countries Available: USA, UK, Germany, France, Singapore, Canada, Australia)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Country',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 350,
                        height: 50,
                        child: TextFormField(
                          controller: _countryController,
                          decoration: InputDecoration(
                            hintText: 'Enter country name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a country';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'University type',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 350,
                        height: 50,
                        child: TextFormField(
                          controller: _universityTypeController,
                          decoration: InputDecoration(
                            hintText: 'Public or Private',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter university type';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Course Specialization',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 350,
                        height: 50,
                        child: TextFormField(
                          controller: _courseSpecializationController,
                          decoration: InputDecoration(
                            hintText: 'eg, Business Administartion',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter course specialization';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Mode of study',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 350,
                        height: 50,
                        child: TextFormField(
                          controller: _modeOfStudyController,
                          decoration: InputDecoration(
                            hintText: 'Full-time or Online',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter mode of study';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    backgroundColor: const Color(0xFF5BA3F8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
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
      ),
    );
  }
}
