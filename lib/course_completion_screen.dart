import 'package:flutter/material.dart';

class CourseCompletionScreen extends StatelessWidget {
  final VoidCallback onGoToHome;

  const CourseCompletionScreen({super.key, required this.onGoToHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Congratulations!'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You have successfully completed the course!',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: onGoToHome,
                child: const Text('Back to Courses'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
