import 'package:flutter/material.dart';
import 'package:mobile/course_completion_screen.dart';
import 'package:mobile/model/course.dart';
import 'package:mobile/quiz_screen.dart';
import 'package:mobile/theory_module_screen.dart';

class CourseDetailsScreen extends StatefulWidget {
  final Course course;

  const CourseDetailsScreen({Key? key, required this.course}) : super(key: key);

  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  int currentModuleIndex = 0;

  void nextModule() {
    if (currentModuleIndex < widget.course.modules.length - 1) {
      setState(() {
        currentModuleIndex++;
      });
    } else {
      // Przekierowanie na ekran gratulacyjny
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CourseCompletionScreen(
            onGoToHome: () {
              Navigator.pop(context); // Powrót do listy kursów
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final module = widget.course.modules[currentModuleIndex];

    if (module.type == 'theory') {
      return TheoryModuleScreen(
        title: module.title!,
        description: module.description!,
        content: module.content!,
        onNext: nextModule,
      );
    } else if (module.type == 'quiz') {
      return QuizScreen(
        questions: module.quizData!,
        onComplete: nextModule,
      );
    } else {
      return const Center(child: Text('Unknown module type'));
    }
  }
}
