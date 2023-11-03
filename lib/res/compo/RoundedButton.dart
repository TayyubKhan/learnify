import 'package:flutter/material.dart';
import 'package:learnify/res/color.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const RoundedButton({super.key, required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width * 0.7,
        height: height * 0.06,
        decoration: BoxDecoration(
            color: button, borderRadius: BorderRadius.circular(35)),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 28, color: font, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
