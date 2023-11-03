import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../ViewViewModel/AudioViewModel.dart';
import '../color.dart';

class ScreenComponent extends StatefulWidget {
  final String screenName;
  final dynamic model;
  final int length;
  final List<String> images;
  final List<Color> prominentColors;
  final List<String> labels;
  final List<String> audio;
  const ScreenComponent(
      {super.key,
      required this.model,
      required this.length,
      required this.images,
      required this.prominentColors,
      required this.labels,
      required this.screenName,
      required this.audio});
  @override
  State<ScreenComponent> createState() => _ScreenComponentState();
}

class _ScreenComponentState extends State<ScreenComponent> {
  Future<void> delay(int index) async {
    i = index;
  }

  int audioo = 0;
  int i = 0;
  final audio = AudioViewModel();
  bool show = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: font,
            ),
          ),
          title: Text(
            widget.screenName,
            style: const TextStyle(color: font, fontSize: 40),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              width: width,
              height: height,
              color: background,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                color: background,
                width: width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.5,
                      child: Swiper(
                        index: i,
                        curve: Curves.easeIn,
                        onIndexChanged: (v) {
                          if (show == true) {
                            show = false;
                            v = i;
                          }
                        },
                        onTap: (v) async {
                          audio.playAudio(widget.audio[v]);
                        },
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (show == true) {
                            index = i;
                          }
                          return Column(
                            children: [
                              Image.asset(
                                height: height * 0.25,
                                widget.images[index],
                              ),
                              Text(
                                widget.labels[index],
                                style: TextStyle(
                                    fontSize: height * 0.05,
                                    color: widget.prominentColors[index],
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          );
                        },
                        itemCount: widget.length,
                        indicatorLayout: PageIndicatorLayout.NONE,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15)),
                  width: width * 0.3,
                  child: GridView.builder(
                      itemCount: widget.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return Image(
                          width: width * 0.05,
                          image: AssetImage(widget.images[index]),
                        );
                      }),
                ),
              ),
              SizedBox(
                width: width * 0.001,
              ),
            ]),
          ],
        ));
  }
}
