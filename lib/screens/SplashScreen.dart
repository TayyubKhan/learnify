import 'dart:async';

import 'package:flutter/material.dart';

import '../res/color.dart';
import 'SignupScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: -1.0, // Start from above the screen
      end: 1.0, // End at the bottom of the screen
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut, // Use the bounce curve
      ),
    );
    // Start the animation
    _controller.forward();
    Timer(const Duration(seconds: 4), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SignupScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: background,
          ),
          child: Center(
              child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                  offset: Offset(
                      0.0,
                      400 *
                          _animation.value.abs()), // Adjust the vertical offset
                  child: const Center(
                    child: Column(
                      children: [
                        Image(image: AssetImage('images/Logo.png')),
                      ],
                    ),
                  ));
            },
          )),
        ));
  }
}
