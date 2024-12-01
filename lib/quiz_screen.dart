import 'package:flutter/material.dart';
import 'package:mobile/model/course.dart';

class QuizScreen extends StatefulWidget {
  final List<QuizQuestion> questions;
  final VoidCallback onComplete;

  const QuizScreen({
    Key? key,
    required this.questions,
    required this.onComplete,
  }) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  List<int> selectedAnswers = [];

  void submitAnswer() {
    final correctAnswers =
        widget.questions[currentQuestionIndex].correctAnswers.toSet();
    final userAnswers = selectedAnswers.toSet();

    if (correctAnswers.difference(userAnswers).isEmpty &&
        userAnswers.difference(correctAnswers).isEmpty) {
      if (currentQuestionIndex < widget.questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          selectedAnswers.clear();
        });
      } else {
        widget.onComplete();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect. Try again!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            ...List.generate(question.options.length, (index) {
              return CheckboxListTile(
                value: selectedAnswers.contains(index),
                title: Text(question.options[index]),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selectedAnswers.add(index);
                    } else {
                      selectedAnswers.remove(index);
                    }
                  });
                },
              );
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: submitAnswer,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
