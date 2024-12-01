import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CheckLinkScreen extends StatefulWidget {
  @override
  _LinkScoreScreenState createState() => _LinkScoreScreenState();
}

class _LinkScoreScreenState extends State<CheckLinkScreen> {
  final TextEditingController _urlController = TextEditingController();
  String _result = '';
  bool _loading = false;

  String getScoreMessage(int score) {
    if (score == 0) {
      return "Link jest bezpieczny";
    } else if (score > 0 && score <= 15) {
      return "Link wygląda na w porządku";
    } else if (score > 15 && score <= 35) {
      return "Link jest podejrzany";
    } else {
      return "Link jest niebezpieczny";
    }
  }

  Future<void> fetchLinkScore(String url) async {
    setState(() {
      _loading = true;
    });

    const String apiKey = 'pk2wHkbaImztP1UfNt07rr8HLN1IpqDo85fIEa2G';
    const String apiUrl = 'https://linkshieldapi.com/api/v1/link/score';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'url': url,
        'follow_redirects': false,
      }),
    );

    setState(() {
      _loading = false;
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final score = data['risk_score'];
        _result = getScoreMessage(score);
      } else {
        _result = 'Error: ${response.statusCode}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Link Score Checker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Enter URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final url = _urlController.text;
                if (url.isNotEmpty) {
                  fetchLinkScore(url);
                }
              },
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Check Score'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
