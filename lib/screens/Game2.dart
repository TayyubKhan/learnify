// ignore_for_file: use_build_context_synchronously

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:learnify/Model/AlphabetModel.dart';

import '../res/ScoreStoring.dart';
import '../res/color.dart';
import '../res/compo/animation dialogue.dart';

class MatchGame extends StatefulWidget {
  @override
  _MatchGameState createState() => _MatchGameState();
}

class _MatchGameState extends State<MatchGame> {
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
  double recognitionScore = 0; // Initialize the recognition score
  int count = 0;
  bool showAppreciation = false;
  final st = StoreScore();
  final alpha = AlphabetModel();
  late List<String> alphabetImages;
  late String correctImage;

  @override
  void initState() {
    super.initState();
    updateImagesForCount(count);
  }

  void updateImagesForCount(int currentCount) {
    // Load the list of alphabet images
    alphabetImages = List<String>.from(alpha.alphabet)..shuffle();

    // Select the correct image based on the current count
    correctImage = alphabetImages[currentCount % 26];
    // Take the first 3 shuffled images as random incorrect choices
    alphabetImages = alphabetImages.sublist(0, 2);
    alphabetImages.add(alpha.alphabet[count]);
    alphabetImages = alphabetImages..shuffle();
  }

  void checkAnswer(String image) async {
    recognitionScore = await st.loadRecognitionScore();
    if (image == alpha.alphabet[count]) {
      await Dialogue('animations/animation_lnbnv8cv.json', context);
      showAppreciation = true;
      st.updateRecognitionScore(recognitionScore + 1);
      count++;
      updateImagesForCount(count);
      setState(() {});
    } else {
      await Dialogue('animations/kHGEEe0E2e.json', context);
      showAppreciation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Match Game',
          style: TextStyle(color: font, fontSize: 40),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Find the image that starts with:',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          Text(letter[count], style: const TextStyle(fontSize: 55)),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                String image =
                    index == 0 ? correctImage : alphabetImages[index - 1];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      checkAnswer(image);
                    });
                  },
                  child: FlipCard(
                    front: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Image.asset(image),
                    ),
                    back: Card(
                      child: Center(
                        child: Text(
                          letter[index],
                          style: const TextStyle(fontSize: 48.0),
                        ),
                      ),
                    ),
                    flipOnTouch: false,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
