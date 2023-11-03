import 'package:flutter/material.dart';

import '../Model/numberModel.dart';
import '../res/compo/Screen.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});
  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  final number = NumberModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenComponent(
      model: number,
      length: number.number.length,
      images: number.number,
      labels: number.title,
      prominentColors: number.color,
      audio: number.audio,
      screenName: 'Counting',
    ));
  }
}
