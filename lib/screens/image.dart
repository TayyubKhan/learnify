// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_drawing_board/flutter_drawing_board.dart';
// import 'package:image/image.dart' as img;
// import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Grayscale Image Pixel Values Example'),
//         ),
//         body: Center(
//           child: GrayscaleImagePixelValuesWidget(),
//         ),
//       ),
//     );
//   }
// }
//
// class GrayscaleImagePixelValuesWidget extends StatefulWidget {
//   @override
//   _GrayscaleImagePixelValuesWidgetState createState() =>
//       _GrayscaleImagePixelValuesWidgetState();
// }
//
// class _GrayscaleImagePixelValuesWidgetState
//     extends State<GrayscaleImagePixelValuesWidget> {
//   final GlobalKey<SfSignaturePadState> signaturePadKey =
//       GlobalKey<SfSignaturePadState>();
//   img.Image? grayscaleImage;
//   List<num> pixelValues = [];
//   int predictedDigit = 11;
//   Future<void> convertToGrayscale(List<int> image) async {
//     final rawImage = img.decodeImage(Uint8List.fromList(image));
//
//     // Resize the image to 28x28 pixels
//     final resizedImage = img.copyResize(rawImage!, width: 28, height: 28);
//     final grayscale = img.grayscale(resizedImage);
//     // Extract the grayscale value from each pixel and store it in pixelValues
//     final List<num> extractedPixelValues = resizedImage.data!
//         .map((pixel) => pixel.a) // Extract the red channel (grayscale value)
//         .toList();
//     final List<img.Pixel> extractedPixel = resizedImage.data!
//         .map((pixel) => pixel) // Extract the red channel (grayscale value)
//         .toList();
//     print(extractedPixel.toList().toString());
//     print(extractedPixelValues.toList().toString());
//
//     setState(() {
//       grayscaleImage = grayscale;
//       pixelValues = extractedPixelValues;
//     });
//     List<num> input = extractedPixelValues.toList();
//     final input2 = Tensor.fillShape(input, 4, [1, 28, 28, 1]);
//     final interpreter =
//         await Interpreter.fromAsset('assets/emnist_model_digits.tflite');
//     print(input);
//     List<double> doubleList =
//         input.map((element) => element.toDouble()).toList();
//     final finalOutput = reshapeList(doubleList, [1, 28, 28, 1]);
//     print(finalOutput.shape);
//     List<List<double>> output = [
//       [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
//     ];
//     interpreter.run(finalOutput, output);
//     double maxVal =
//         output.first.reduce((max, element) => max > element ? max : element);
//     predictedDigit = output.first.indexOf(maxVal);
//   }
//
//   List<List<List<List<T>>>> reshapeList<T>(List<T> flatList, List<int> shape) {
//     if (flatList.length != shape.reduce((a, b) => a * b)) {
//       throw ArgumentError(
//           'Input list length must match the product of the shape dimensions.');
//     }
//     List<List<List<List<T>>>> reshapedTensor = [];
//
//     int currentIndex = 0;
//
//     for (int i = 0; i < shape[0]; i++) {
//       List<List<List<T>>> dim1 = [];
//       for (int j = 0; j < shape[1]; j++) {
//         List<List<T>> dim2 = [];
//         for (int k = 0; k < shape[2]; k++) {
//           List<T> dim3 = [];
//           for (int l = 0; l < shape[3]; l++) {
//             dim3.add(flatList[currentIndex]);
//             currentIndex++;
//           }
//           print(dim3);
//           dim2.add(dim3);
//         }
//         dim1.add(dim2);
//       }
//       reshapedTensor.add(dim1);
//     }
//
//     return reshapedTensor;
//   }
//
//   List<Path> signaturePoints = [];
//   final DrawingController _drawingController = DrawingController();
//   List first10Pixels = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("ML model Testing"),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 35),
//             child: InkWell(
//                 onTap: () {
//                   signaturePadKey.currentState!.clear();
//                 },
//                 child: const Icon(Icons.close)),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               width: 200,
//               height: 200,
//               color: Colors.white,
//               child: SfSignaturePad(
//                 key: signaturePadKey,
//                 onDrawEnd: () {
//                   setState(() {
//                     signaturePoints =
//                         signaturePadKey.currentState!.toPathList();
//                   });
//                 },
//                 // Customize the signature pad here as needed
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final sign = await signaturePadKey.currentState?.toImage();
//                 final bytes =
//                     await sign!.toByteData(format: ImageByteFormat.png);
//                 final List<int> png = bytes!.buffer.asUint8List();
//                 await convertToGrayscale(png!);
//                 first10Pixels = pixelValues.toList();
//               },
//               child: const Text('Predict The Model'),
//             ),
//             const SizedBox(height: 20),
//             if (predictedDigit != 11)
//               Text(
//                 'Predicted Digit= $predictedDigit',
//                 style: const TextStyle(fontSize: 30),
//               )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Ink;
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'package:lottie/lottie.dart';

import '../res/color.dart';

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
      appBar: AppBar(
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
            Text(
              practiceItems[currentIndex],
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 8),
            SizedBox(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            practiceItems[currentIndex],
                            style: TextStyle(
                                fontFamily: 'hand', fontSize: height * 0.35),
                          ),
                          Text(
                            practiceItems[currentIndex].toLowerCase(),
                            style: TextStyle(
                                fontFamily: 'hand', fontSize: height * 0.35),
                          ),
                        ],
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
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => background)),
                  onPressed: _clearPad,
                  child: const Text('Erase'),
                ),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => background)),
              onPressed: () async {
                bool correct = false;
                final candidates = await _digitalInkRecognizer.recognize(_ink);
                for (final candidate in candidates) {
                  if (candidate.text
                      .toLowerCase()
                      .contains(practiceItems[currentIndex].toLowerCase())) {
                    correct = true;
                    break;
                  }
                }
                if (correct == true) {
                  await Dialogue('animations/animation_lnbsqiir.json');
                  setState(() {
                    _clearPad();
                    currentIndex++;
                  });
                  if (kDebugMode) {
                    print('Correct');
                  }
                } else {
                  await Dialogue('animations/animation_lnbsqiir.json');

                  _clearPad();
                  print(_recognizedText);
                  if (kDebugMode) {
                    print('Incorrect');
                  }
                }
              },
              child: const Text('Test'),
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
