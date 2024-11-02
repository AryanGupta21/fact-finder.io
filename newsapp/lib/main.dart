import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Classifier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsClassifier(),
    );
  }
}

class NewsClassifier extends StatefulWidget {
  @override
  _NewsClassifierState createState() => _NewsClassifierState();
}

class _NewsClassifierState extends State<NewsClassifier> {
  TextEditingController _controller = TextEditingController();
  String _result = "";

  // Function to send the user input to the Python backend
  Future<void> _classifyNews(String newsText) async {
    final url = Uri.parse('http://localhost:5000/predict');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"text": newsText}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      setState(() {
        _result = result['prediction'];
      });
    } else {
      setState(() {
        _result = "Error: Could not classify the news.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Classifier'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter news article',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _classifyNews(_controller.text);
              },
              child: Text('Classify News'),
            ),
            SizedBox(height: 16),
            Text(
              'Prediction: $_result',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
