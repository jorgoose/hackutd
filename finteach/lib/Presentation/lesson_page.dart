import 'package:finteach/Domain/chapter.dart';
import 'package:finteach/Domain/question.dart';
import 'package:finteach/services/openai_service.dart';
import 'package:flutter/material.dart';
import 'package:finteach/Application/constants.dart';
import 'package:confetti/confetti.dart'; // Import the confetti package

class LessonPage extends StatefulWidget {
  final String title;
  final Chapters chapter; // Corrected to 'Chapter'

  const LessonPage({Key? key, required this.title, required this.chapter})
      : super(key: key);

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  int currentQuestionIndex = 0;
  int currentQuestion = 1;
  double progressValue = 0;

  bool isDataLoaded = false;
  String chatGptSaid = '';
  bool _hasPressedCheck = false;
  int selectedOptionIndex = -1; // Add this to track selected option
  List<Question> questions = loadQuestions();
  final ConfettiController _confettiController = ConfettiController(duration: const Duration(seconds: 1)); // Add this

  @override
  void dispose() {
    _confettiController.dispose(); // Add this to dispose of the controller
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Your existing code
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        Column(
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
                  SizedBox(width: 16), // Increased space between the progress bar and the heart
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
                      Color(0xFF11825C), // Darker green gradient
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 24),
                      _buildCombinedCard(context, questions[currentQuestionIndex]), // Pass the current question
                      SizedBox(height: 24),
                      Expanded(
                        child: ListView.builder( // Use ListView.builder to build options
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: questions[currentQuestionIndex].options.length, // Number of options for the current question
                          itemBuilder: (context, index) {
                            return _buildOption(context, questions[currentQuestionIndex].options[index], index); // Pass the option and its index
                          },
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
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  child: Center(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        textStyle: const TextStyle(fontSize: 18),
      ),
      // Change button text based on _hasPressedCheck
      child: Text(_hasPressedCheck ? 'Next Question' : 'Check'),
      onPressed: () {
        if (!_hasPressedCheck) {
          setState(() {
            if (selectedOptionIndex == questions[currentQuestionIndex].answerIndex) {
              progressValue += 0.1;
              _confettiController.play(); // Play confetti animation if correct
                            progressValue += 1 / questions.length;

            } else {
              questions.add(questions[currentQuestionIndex]);
              print('wrong'); // Print 'wrong' if incorrect

            }
            _hasPressedCheck = true; // Update the flag to indicate the check has been pressed
          });
        } else {
          // If 'Next Question' is pressed
          setState(() {
            if (currentQuestionIndex < questions.length - 1) {
              currentQuestionIndex++;
              _hasPressedCheck = false; // Reset the check button state
              selectedOptionIndex = -1; // Reset the selected option
            } else {
              _showCompletionDialog(context, _confettiController);
            }
          });
        }
      },
    ),
  ),
),

          ],
        ),
        // Confetti
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive, // don't specify a direction, blast randomly
            shouldLoop: false, // start again as soon as the animation is finished
            colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple], // manually specify the colors to be used
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
      value: progressValue,
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

Widget _buildOption(BuildContext context, String option, int index) {
  Color? _getOptionColor(int index) {
    if (!_hasPressedCheck) {
      // If the option is selected and check has not been pressed, make it grey
      return selectedOptionIndex == index ? Colors.grey : Colors.white;
    } else {
      // If check has been pressed, use the answer logic colors
      if (index == questions[currentQuestionIndex].answerIndex) {
        return Colors.lightGreenAccent;
      } else if (selectedOptionIndex == index && selectedOptionIndex != questions[currentQuestionIndex].answerIndex) {
        return Colors.redAccent;
      }
    }
    return Colors.white; // Default color when none of the above conditions meet
  }

  return Card(
    color: _getOptionColor(index),
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: ListTile(
      title: Text(option, style: TextStyle(color: Colors.black)),
      onTap: !_hasPressedCheck ? () {
        setState(() {
          // Only change the selection if the check hasn't been pressed
          selectedOptionIndex = index;
        });
      } : null, // Disable tap if the check has been pressed
    ),
  );
}



  Widget _buildCombinedCard(BuildContext context, Question question) {
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
                text: 'Question ${currentQuestionIndex + 1} of ${questions.length}\n', // Update the question count dynamically
                style: TextStyle(
                  fontWeight: FontWeight.w400, color: Colors.grey
                ),
              ),
              TextSpan(
                text: question.question, // Use the text from the Question object
                style: TextStyle(fontWeight: FontWeight.bold, height: 1.5)
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  void _showCompletionDialog(context, _confettiController) {
    showDialog(
      context: context,
      barrierDismissible: false, // The user must tap the button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Center(
                  child: Text(
                    "🏅",
                    style: TextStyle(
                      fontSize: 100, // Set a very large font size for the emoji
                    ),
                  ),
                ),
                const Text('You have completed all the questions!'),
                const Text('Your progress has been amazing!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Go Home'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Go back to the previous screen
                _confettiController.stop(); // Stop the confetti when the dialog is closed
              },
            ),
          ],
        );
      },
    );
    // Start the confetti loop when the dialog is shown
    _confettiController.play();
  }