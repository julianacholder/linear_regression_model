import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Main quiz page widget that handles tuition fee predictions
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Form key to handle validation
  final _formKey = GlobalKey<FormState>();

  // Text controllers for each input field
  final _countryController = TextEditingController();
  final _universityTypeController = TextEditingController();
  final _courseSpecializationController = TextEditingController();
  final _modeOfStudyController = TextEditingController();

  // Loading state for the submit button
  bool _isLoading = false;

  // Handles form submission and API call
  Future<void> _submitForm() async {
    // Only proceed if all form fields are valid
    if (_formKey.currentState!.validate()) {
      // Show loading spinner
      setState(() {
        _isLoading = true;
      });

      try {
        // Make API call to prediction endpoint
        final response = await http.post(
          Uri.parse('https://predict-tuition.onrender.com/predict'),
          headers: {
            'Content-Type': 'application/json',
          },
          // Convert form data to JSON
          body: jsonEncode({
            'country': _countryController.text,
            'univ_type': _universityTypeController.text,
            'course_type': _courseSpecializationController.text,
            'mode_of_study': _modeOfStudyController.text,
          }),
        );

        // Handle successful API response
        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);

          // Add additional data to result
          result['country'] = _countryController.text;
          result['course_type'] = _courseSpecializationController.text;

          // Navigate to results page with prediction data
          Navigator.pushNamed(
            context,
            '/result',
            arguments: result,
          );
        } else {
          // Handle API error response
          String errorMessage;
          try {
            // Try to parse error message from JSON response
            final errorBody = jsonDecode(response.body);
            errorMessage = errorBody['message'] ??
                errorBody['error'] ??
                'Server returned: ${response.body}';
          } catch (e) {
            // If JSON parsing fails, use raw response
            errorMessage = 'Server returned: ${response.body}';
          }

          // Show error dialog with details
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Status Code: ${response.statusCode}'),
                      const SizedBox(height: 8),
                      Text(errorMessage),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        // Handle network or other errors
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Connection Error'),
              content: SingleChildScrollView(
                child: Text('Error details:\n${e.toString()}'),
              ),
              actions: [
                TextButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      } finally {
        // Hide loading spinner
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Clean up controllers when widget is disposed
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
                // Page title
                const Text(
                  "Predict Tuition Fees",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                // Description text
                const Text(
                  "Discover and compare tuition fees for some of the most sought-after master's programs across top study destinations!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                // Available countries info
                const Text(
                  "(Countries Available: USA, UK, Germany, France, Singapore, Canada, Australia)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                // Main form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Country input field
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
                      // University type input field
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
                      // Course specialization input field
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
                            hintText: 'eg, Business Administration',
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
                      // Mode of study input field
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
                // Submit button with loading state
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
