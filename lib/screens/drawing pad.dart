import 'dart:async';

import 'package:flutter/material.dart' hide Ink;
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'package:lottie/lottie.dart';

import '../res/color.dart';
// ignore_for_file: use_build_context_synchronously

class DigitalInkView extends StatefulWidget {
  @override
  State<DigitalInkView> createState() => _DigitalInkViewState();
}

class _DigitalInkViewState extends State<DigitalInkView> {
  Future<dynamic> Dialogue(String animation) async => showDialog(
      context: context,
      builder: (context) {
        Timer(const Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return Lottie.asset(animation);
      });
  final DigitalInkRecognizerModelManager _modelManager =
      DigitalInkRecognizerModelManager();
  var _language = 'en';
  final _languages = [
    'en',
    'ur',
    'fr',
    'hi',
    'it',
    'ja',
    'pt',
    'ru',
    'zh-Hani',
  ];
  var _digitalInkRecognizer = DigitalInkRecognizer(languageCode: 'en');
  final Ink _ink = Ink();
  List<StrokePoint> _points = [];
  String _recognizedText = '';

  @override
  void dispose() {
    _digitalInkRecognizer.close();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelManager.isModelDownloaded(_language).then((value) => {
          if (value == false) {_modelManager.downloadModel('en')}
        });
  }

  int currentIndex = 0;
  List<String> practiceItems = [
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
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];

  Color strokeColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: background,
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
        title: const Text(
          'Drawing Screen',
          style: TextStyle(color: font, fontSize: 40),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white.withOpacity(0.2),
              height: height * 0.5,
              width: width,
              child: GestureDetector(
                onPanStart: (DragStartDetails details) {
                  _ink.strokes.add(Stroke());
                },
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    final RenderObject? object = context.findRenderObject();
                    final localPosition = (object as RenderBox?)
                        ?.globalToLocal(details.localPosition);
                    if (localPosition != null) {
                      _points = List.from(_points)
                        ..add(StrokePoint(
                          x: localPosition.dx,
                          y: localPosition.dy,
                          t: DateTime.now().millisecondsSinceEpoch,
                        ));
                    }
                    if (_ink.strokes.isNotEmpty) {
                      _ink.strokes.last.points = _points.toList();
                    }
                  });
                },
                onPanEnd: (DragEndDetails details) {
                  _points.clear();
                  setState(() {});
                },
                child: ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: CustomPaint(
                    painter: Signature(ink: _ink, color: strokeColor),
                    size: Size.infinite,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          practiceItems[currentIndex],
                          style: TextStyle(
                              fontFamily: 'hand', fontSize: height * 0.35),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      strokeColor = Colors.black;
                    });
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      strokeColor = Colors.blue;
                    });
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      strokeColor = Colors.pink;
                    });
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      strokeColor = Colors.green;
                    });
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
                SizedBox(width: width * 0.4),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateColor.resolveWith((states) => font)),
                  onPressed: _clearPad,
                  child: const Text(
                    'Erase',
                    style: TextStyle(color: background),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => font)),
              onPressed: () async {
                currentIndex++;
              },
              child: const Text(
                'Next',
                style: TextStyle(color: background),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearPad() {
    setState(() {
      _ink.strokes.clear();
      _points.clear();
      _recognizedText = '';
    });
  }

  // Future<void> _isModelDownloaded() async {
  //   Toast().show(
  //       'Checking if model is downloaded...',
  //       _modelManager
  //           .isModelDownloaded(_language)
  //           .then((value) => value ? 'downloaded' : 'not downloaded'),
  //       context,
  //       this);
  // }
  //
  // Future<void> _deleteModel() async {
  //   Toast().show(
  //       'Deleting model...',
  //       _modelManager
  //           .deleteModel(_language)
  //           .then((value) => value ? 'success' : 'failed'),
  //       context,
  //       this);
  // }
  //
  // Future<void> _downloadModel() async {
  //   Toast().show(
  //       'Downloading model...',
  //       _modelManager
  //           .downloadModel(_language)
  //           .then((value) => value ? 'success' : 'failed'),
  //       context,
  //       this);
  // }
  // Future<void> _recogniseText() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) => const AlertDialog(
  //             title: Text('Recognizing'),
  //           ),
  //       barrierDismissible: true);
  //   try {
  //
  //     for (final candidate in candidates) {
  //       _recognizedText += '\n${candidate.text}';
  //     }
  //     setState(() {});
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(e.toString()),
  //     ));
  //   }
  //   Navigator.pop(context);
  // }
}

class Signature extends CustomPainter {
  Ink ink;
  Color color;
  Signature({required this.ink, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for (final stroke in ink.strokes) {
      for (int i = 0; i < stroke.points.length - 1; i++) {
        final p1 = stroke.points[i];
        final p2 = stroke.points[i + 1];
        canvas.drawLine(Offset(p1.x.toDouble(), p1.y.toDouble()),
            Offset(p2.x.toDouble(), p2.y.toDouble()), paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => true;
}
// child: Center(
// child: Text(
// 'A',
// style: TextStyle(fontSize: 200),
// textAlign: TextAlign.center,
// ),
// ),
