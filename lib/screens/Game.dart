import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:learnify/Model/AlphabetModel.dart';
import 'package:learnify/res/color.dart';

import '../ViewViewModel/AudioViewModel.dart';

class FlipGame extends StatefulWidget {
  const FlipGame({super.key});

  @override
  _FlipGameState createState() => _FlipGameState();
}

class _FlipGameState extends State<FlipGame> {
  List<String> letter = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];
  final audio = AudioViewModel();

  List<bool> flipped = List.filled(26, false); // To track flipped cards
  final alpha = AlphabetModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Flip Game',
          style: TextStyle(color: font, fontSize: 40),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: alpha.alphabet.length,
        itemBuilder: (context, index) {
          return Center(
            child: FlipCard(
              speed: 1000,
              onFlip: () {
                audio.playAudio(alpha.alphabetAudio[index]);
                setState(() {
                  flipped[index] = !flipped[index];
                });
              },
              front: Card(
                color: Colors.transparent,
                elevation: 0,
                child: Image.asset(alpha.alphabet[index]),
              ),
              back: Card(
                color: Colors.transparent,
                elevation: 0,
                child: Center(
                  child: Text(
                    letter[index],
                    style: const TextStyle(fontSize: 150.0, color: font),
                  ),
                ),
              ),
              flipOnTouch: !flipped[index],
            ),
          );
        },
      ),
    );
  }
}
