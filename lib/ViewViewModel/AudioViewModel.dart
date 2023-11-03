import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class AudioViewModel {
  void playAudio(String audioUrl) async {
    AudioPlayer audioPlayer = AudioPlayer();
    final ByteData data = await rootBundle.load(audioUrl);
    Uint8List buffer = data.buffer.asUint8List();
    await audioPlayer.play(BytesSource(buffer));
  }
}
