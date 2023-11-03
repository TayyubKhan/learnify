import 'package:flutter/material.dart';
import 'package:learnify/Model/Home_screenModel.dart';
import 'package:learnify/screens/AlphabetScreen.dart';
import 'package:learnify/screens/AnimalScreen.dart';
import 'package:learnify/screens/TestingScreen.dart';

import '../res/ScoreStoring.dart';
import '../res/color.dart';
import 'Analytics.dart';
import 'Game.dart';
import 'Game2.dart';
import 'NumberScreen.dart';
import 'drawing pad.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final st = StoreScore();
  List<Widget> screens = [
    const AlphabetScreen(),
    const NumberScreen(),
    const AnimalsScreen(),
    DigitalInkView(),
    const FlipGame(),
     MatchGame(),
    const TestingScreen(),
    AnalyticScreen(),
  ];
  HomeScreenModel homeModel = HomeScreenModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: background,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: height * 0.045,
                      child: const Image(
                        image: AssetImage('images/Dp.png'),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.008,
                    ),
                    const Text(
                      'Jerry',
                      style: TextStyle(
                          color: font,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: homeModel.title.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: height * 0.23,
                      maxCrossAxisExtent: width * .45,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => screens[index]));
                          },
                          child: Container(
                            width: width * .45,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 0.5),
                                color: const Color(0xfffee473),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(offset: Offset(1, 1), blurRadius: 2)
                                ]),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                      height: height * 0.14,
                                      image:
                                          AssetImage(homeModel.images[index])),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Text(
                                    homeModel.title[index],
                                    style: const TextStyle(
                                        fontSize: 18, color: font),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
