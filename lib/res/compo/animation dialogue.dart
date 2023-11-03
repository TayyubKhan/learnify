import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<dynamic> Dialogue(String animation, BuildContext context) async =>
    showDialog(
        context: context,
        builder: (context) {
          Timer(const Duration(seconds: 3), () {
            Navigator.pop(context);
          });
          return Lottie.asset(animation);
        });
