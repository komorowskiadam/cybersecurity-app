class QuizQuestion {
  final String question;
  final List<String> options;
  final List<int> correctAnswers;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswers,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswers: List<int>.from(json['correctAnswers']),
    );
  }
}

class TheoryContent {
  final String type; // "text", "image", "list"
  final dynamic value; // String lub List<String> w zależności od typu

  TheoryContent({required this.type, required this.value});

  factory TheoryContent.fromJson(Map<String, dynamic> json) {
    return TheoryContent(
      type: json['type'],
      value: json['type'] == 'list'
          ? List<String>.from(json['value'])
          : json['value'],
    );
  }
}

class Module {
  final String type; // "theory" lub "quiz"
  final String? title; // dla teorii
  final String? description; // dla teorii
  final List<TheoryContent>? content; // dla teorii
  final List<QuizQuestion>? quizData; // dla quizu

  Module({
    required this.type,
    this.title,
    this.description,
    this.content,
    this.quizData,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      type: json['type'],
      title: json['type'] == 'theory' ? json['title'] : null,
      description: json['type'] == 'theory' ? json['description'] : null,
      content: json['type'] == 'theory'
          ? (json['content'] as List<dynamic>)
              .map((c) => TheoryContent.fromJson(c))
              .toList()
          : null,
      quizData: json['type'] == 'quiz'
          ? (json['quizData']['questions'] as List<dynamic>)
              .map((q) => QuizQuestion.fromJson(q))
              .toList()
          : null,
    );
  }
}

class Course {
  final int id;
  final String title;
  final String description;
  final List<Module> modules;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.modules,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      modules: (json['modules'] as List<dynamic>)
          .map((moduleJson) => Module.fromJson(moduleJson))
          .toList(),
    );
  }
}

// {
//     "id": 4,
//     "title": "",
//     "description": "",
//     "modules": [
//       {
//         "type": "theory",
//         "title": "",
//         "description": "",
//         "content": [
//           {
//             "type": "text",
//             "value": ""
//           },
//           {
//             "type": "list",
//             "value": ["", "", "", ""]
//           },
//           {
//             "type": "image",
//             "value": "assets/images/grafika5.jpeg"
//           }
//         ]
//       },
//       {
//         "type": "theory",
//         "title": "",
//         "description": "",
//         "content": [
//           {
//             "type": "text",
//             "value": ""
//           },
//           {
//             "type": "list",
//             "value": ["", "", "", ""]
//           },
//           {
//             "type": "image",
//             "value": "assets/images/grafika5.jpeg"
//           }
//         ]
//       },
//       {
//         "type": "theory",
//         "title": "",
//         "description": "",
//         "content": [
//           {
//             "type": "text",
//             "value": ""
//           },
//           {
//             "type": "list",
//             "value": ["", "", "", ""]
//           },
//           {
//             "type": "image",
//             "value": "assets/images/grafika5.jpeg"
//           }
//         ]
//       }
//     ]
//   }
