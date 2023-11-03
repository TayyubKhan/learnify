import 'package:flutter/material.dart' hide Ink;
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';

import '../res/ScoreStoring.dart';
import '../res/color.dart';
import '../res/compo/animation dialogue.dart';
// ignore_for_file: use_build_context_synchronously

class TestingScreen extends StatefulWidget {
  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  double writingScore = 0;
  final DigitalInkRecognizerModelManager _modelManager =
      DigitalInkRecognizerModelManager();
  final _digitalInkRecognizer = DigitalInkRecognizer(languageCode: 'en');
  final Ink _ink = Ink();
  List<StrokePoint> _points = [];
  String _recognizedText = '';

  @override
  void dispose() {
    _digitalInkRecognizer.close();
    super.dispose();
  }

  final st = StoreScore();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelManager.isModelDownloaded('en').then((value) => {
          if (value == false) {_modelManager.downloadModel('en')}
        });
  }

  List<Map<String, dynamic>> score = [];
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
          'Test Screen',
          style: TextStyle(color: font, fontSize: 40),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    practiceItems[currentIndex],
                    style: TextStyle(
                        fontSize: width * 0.4, fontWeight: FontWeight.w100),
                  ),
                ),
                Container(
                  color: Colors.white.withOpacity(0.2),
                  height: height * 0.5,
                  width: width * 0.6,
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
                      ),
                    ),
                  ),
                ),
              ],
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
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => background)),
                  onPressed: _clearPad,
                  child: const Text('Erase', style: TextStyle(color: font)),
                ),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => background)),
              onPressed: () async {
                st.loadWritingScore().then((value) {
                  writingScore = value;
                }).onError((error, stackTrace) {});
                bool correct = false;
                final candidates = await _digitalInkRecognizer.recognize(_ink);
                for (final candidate in candidates) {
                  if (candidate.text
                      .toLowerCase()
                      .contains(practiceItems[currentIndex].toLowerCase())) {
                    correct = true;
                    score.add({
                      'alpha': practiceItems[currentIndex].toString(),
                      'score': candidate.toString()
                    });
                    break;
                  }
                }
                if (correct == true) {
                  writingScore++;
                  st.updateWritingScore(writingScore);
                  await Dialogue('animations/animation_lnbnv8cv.json', context);
                  setState(() {
                    _clearPad();
                    currentIndex++;
                  });
                } else {
                  writingScore--; // Increment the writing score
                  st.updateWritingScore(writingScore > 0 ? writingScore : 0);
                  await Dialogue('animations/kHGEEe0E2e.json', context);
                  _clearPad();
                }
              },
              child: const Text(
                'Test',
                style: TextStyle(color: font),
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
