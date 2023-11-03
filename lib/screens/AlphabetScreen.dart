import 'package:flutter/material.dart';
import 'package:learnify/Model/AlphabetModel.dart';
import 'package:learnify/res/compo/Screen.dart';

class AlphabetScreen extends StatefulWidget {
  const AlphabetScreen({super.key});
  @override
  State<AlphabetScreen> createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  AlphabetModel alpha = AlphabetModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenComponent(
      model: alpha,
      length: alpha.alphabet.length,
      images: alpha.alphabet,
      labels: alpha.title,
      audio: alpha.alphabetAudio,
      screenName: 'Alphabet',
      prominentColors: alpha.color,
    ));
  }
}
