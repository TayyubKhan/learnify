import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learnify/res/color.dart';
import 'package:learnify/res/compo/RoundedButton.dart';
import 'package:learnify/res/compo/TextFormField.dart';
import 'package:learnify/screens/HomeScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPressed = false;
  bool isPressed2 = false;
  double v = 0.0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: background, // Change to your desired color
    ));
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: Container(
            height: height,
            width: width,
            color: background,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                SizedBox(
                  height: height * 0.1,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(image: AssetImage('images/Logo.png')),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AppTextFormField(
                    hint: 'Name',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AppTextFormField(
                    hint: 'Age',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPressed = true;
                              isPressed2 = false;
                            });
                          },
                          onTapCancel: () {
                            setState(() {
                              isPressed = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: isPressed
                                ? width * 0.35
                                : width * 0.3, // Adjust the sizes as needed
                            child: Image(
                              image: const AssetImage('images/boy.png'),
                              width: width * 0.4,
                            ), // Replace with your image path
                          ),
                        ),
                        const Text(
                          'Boy',
                          style: TextStyle(
                              color: font,
                              fontWeight: FontWeight.w500,
                              fontSize: 21),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPressed = false;
                              isPressed2 = true;
                            });
                          },
                          onTapCancel: () {
                            setState(() {
                              isPressed2 = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: isPressed2 ? width * 0.35 : width * 0.3,
                            child: Image(
                              image: const AssetImage('images/girl.png'),
                              width: width * 0.4,
                            ), // Replace with your image path
                          ),
                        ),
                        const Text(
                          'Girl',
                          style: TextStyle(
                              color: font,
                              fontWeight: FontWeight.w500,
                              fontSize: 21),
                        )
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AppTextFormField(
                    hint: 'Password',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AppTextFormField(
                    hint: 'Repeat Password',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: RoundedButton(
                      title: 'SignUp',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      }),
                )
              ]),
            )),
      ),
    );
  }
}
