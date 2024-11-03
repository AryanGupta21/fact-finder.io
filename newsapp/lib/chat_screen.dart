import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];

  // Function to send the user input to the Python backend
  Future<void> _classifyNews(String newsText) async {
    final url = Uri.parse('http://192.168.29.137:5000/predict');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"text": newsText}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      String prediction = result['prediction'] == 'true'
          ? "The news is most likely to be true."
          : "The news is most likely to be fake.";

      setState(() {
        messages.add({"user": newsText, "bot": prediction});
      });
    } else {
      setState(() {
        messages.add(
            {"user": newsText, "bot": "Error: Could not classify the news."});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/image.png', // Your RV logo image
              height: 40,
            ),
            const SizedBox(
              width: 200, // Set your desired width
              child: Text(
                'RV CHECKER',
                selectionColor: Colors.black,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24, // Adjust font size as needed
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(
            255, 6, 68, 130), // AppBar theme color changed to blue
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChatBubble(
                      message: messages[index]['user']!,
                      isUser: true,
                    ),
                    const SizedBox(height: 8),
                    ChatBubble(
                      message: "Prediction: ${messages[index]['bot']!}",
                      isUser: false,
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Give me your news...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _classifyNews(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isUser ? 12 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 12),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            color: isUser ? Colors.black : Colors.black87,
          ),
        ),
      ),
    );
  }
}
