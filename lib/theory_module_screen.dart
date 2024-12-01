import 'package:flutter/material.dart';
import 'package:mobile/model/course.dart';

class TheoryModuleScreen extends StatelessWidget {
  final String title;
  final String description;
  final List<TheoryContent> content;
  final VoidCallback onNext;

  const TheoryModuleScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.content,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
              description,
              style:
                  const TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: content.length,
                itemBuilder: (context, index) {
                  final item = content[index];
                  if (item.type == 'text') {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        item.value,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    );
                  } else if (item.type == 'image') {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.asset(item.value),
                    );
                  } else if (item.type == 'list') {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (item.value as List<String>)
                            .map((point) => Text(
                                  '• $point',
                                  style: const TextStyle(fontSize: 16.0),
                                ))
                            .toList(),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: onNext,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
