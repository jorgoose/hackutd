import 'package:flutter/material.dart';
import '../services/openai_service.dart';
import 'package:finteach/Presentation/confetti.dart';

class PracticePage extends StatefulWidget {
  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final TextEditingController _queryController = TextEditingController();
  final GlobalKey<ConfettiButtonState> confettiKey = GlobalKey<ConfettiButtonState>(); // Define the key here
  String _response = "";
  bool _isLoading = false;

  final OpenAIService _openAIService = OpenAIService();

  void _submitQuery() async {
    setState(() {
      _isLoading = true;
    });

    String response = await _openAIService.getResponse(_queryController.text);

    setState(() {
      _response = response;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _queryController,
              decoration: InputDecoration(
                hintText: 'Enter your query here',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _submitQuery(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitQuery,
              child: Text(_isLoading ? 'Loading...' : 'Submit'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_response),
              ),
            ),
            ConfettiButton(key: confettiKey),
            FloatingActionButton(
              onPressed: () {
                confettiKey.currentState?.playConfetti(); // Use the key to call playConfetti
              },
              child: Icon(Icons.edit, color: Colors.black), 
              backgroundColor: Colors.white,
              tooltip: 'Practice',
            ),
          ],
        ),
      ),
    );
  }
}
