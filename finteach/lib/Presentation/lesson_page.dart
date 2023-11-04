import 'package:flutter/material.dart';

class LessonPage extends StatelessWidget {
  final String moduleNumber;

  const LessonPage({Key? key, required this.moduleNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top bar with white background
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCloseButton(context),
                SizedBox(width: 8), // Added space before the progress bar
                Expanded(
                  child: _buildProgressBar(),
                ),
                SizedBox(
                    width:
                        16), // Increased space between the progress bar and the heart
                _buildHeartCount(context, heartCount: 5),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green, // Lighter green gradient
                    Color(0xFF11825C) // Darker green gradient
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                top: false, // SafeArea is now only needed for bottom part
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 24),
                    _buildCombinedCard(context, 'Question 1 of 5',
                        'This is an example question, what is the answer for it?'),
                    SizedBox(height: 24),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        children: [
                          _buildOption(context, 'Option 1'),
                          _buildOption(context, 'Option 2'),
                          _buildOption(context, 'Option 3'),
                          _buildOption(context, 'Option 4'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom bar with white background
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 16.0), // Increased padding for a bigger button
                  textStyle:
                      const TextStyle(fontSize: 18), // Increased font size
                ),
                child: Text('Next Question'),
                onPressed: () {
                  // Handle next question action
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close, color: Colors.green),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      value: 0.2, // Current progress
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
    );
  }

  Widget _buildHeartCount(BuildContext context, {required int heartCount}) {
    return Row(
      children: [
        const Icon(Icons.favorite, color: Colors.red),
        SizedBox(width: 8),
        Text('$heartCount', style: const TextStyle(color: Colors.black)),
      ],
    );
  }

  Widget _buildOption(BuildContext context, String option) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(option, style: const TextStyle(color: Colors.black)),
        onTap: () {
          // Handle option tap action
        },
      ),
    );
  }

  Widget _buildCombinedCard(
      BuildContext context, String questionNumber, String questionText) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(fontSize: 14.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                  text: '$questionNumber\n',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.grey)),
              TextSpan(
                  text: questionText,
                  style: TextStyle(fontWeight: FontWeight.bold, height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }
}
