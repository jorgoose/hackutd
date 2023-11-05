import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

// Use a key of type GlobalKey<ConfettiButtonState>, not _ConfettiButtonState.
class ConfettiButton extends StatefulWidget {
  final GlobalKey<ConfettiButtonState> key;

  ConfettiButton({required this.key}) : super(key: key);

  @override
  ConfettiButtonState createState() => ConfettiButtonState();
}

class ConfettiButtonState extends State<ConfettiButton> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 3));
  }

  void playConfetti() {
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ConfettiWidget(
          confettiController: _controller,
          blastDirectionality: BlastDirectionality.directional,
          blastDirection: -pi/1.67,
          shouldLoop: false,
          maxBlastForce: 60, 
          minBlastForce: 20, 
          emissionFrequency: 0.05, // more frequent emissions
          numberOfParticles: 30, // number of particles to emit
          gravity: 0.4, // set a low gravity
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple
          ],
        ),
        FloatingActionButton(
          onPressed: () {
            _controller.play();
          },
          child: Icon(Icons.party_mode),
          tooltip: 'Launch Confetti',
        ),
      ],
    );
  }
}


