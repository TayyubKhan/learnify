import 'package:flutter/material.dart';
import 'package:learnify/Model/AnimalModel.dart';

import '../res/compo/Screen.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({super.key});
  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  final animal = AnimalsModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenComponent(
      model: animal,
      length: animal.animals.length,
      images: animal.animals,
      labels: animal.title,
      audio: animal.audio,
      prominentColors: animal.color,
      screenName: 'Animals',
    ));
  }
}
