import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped }

class TtsProvider extends ChangeNotifier {
  FlutterTts tts = FlutterTts();
  Map<int, String> lines = Map.from({});
  TtsState ttsState = TtsState.stopped;

  int playingLine = 1;

  double _volume = 1.0;
  double _pitch = 1.0;
  double _rate = 0.5;

  TtsProvider() {
    tts.setLanguage("en-US");
    tts.setVolume(_volume);
    tts.setPitch(_pitch);
    tts.setSpeechRate(_rate);

    tts.setStartHandler(() {
      ttsState = TtsState.playing;
      notifyListeners();
    });

    tts.setCompletionHandler(() {
      ttsState = TtsState.stopped;
      notifyListeners();
    });
  }

  double get volume => _volume;
  double get pitch => _pitch;
  double get rate => _rate;

  void increaseVolume() {
    _volume += 0.1;
    tts.setVolume(_volume);
    notifyListeners();
  }

  void decreaseVolume() {
    _volume -= 0.1;
    tts.setVolume(_volume);
    notifyListeners();
  }

  void increasePitch() {
    _pitch += 0.1;
    tts.setPitch(_pitch);
    notifyListeners();
  }

  void decreasePitch() {
    _pitch -= 0.1;
    tts.setPitch(_pitch);
    notifyListeners();
  }

  void increaseRate() {
    _rate += 0.1;
    tts.setSpeechRate(_rate);
    notifyListeners();
  }

  void decreaseRate() {
    _rate -= 0.1;
    tts.setSpeechRate(_rate);
    notifyListeners();
  }

  Future<void> _speak(String text) async {
    await tts.awaitSpeakCompletion(true);
    await tts.awaitSynthCompletion(true);
    final res = await tts.speak(text);
    if (res == 1) {
      ttsState = TtsState.playing;
      notifyListeners();
    }
  }

  Future<void> playPause() async {
    if (ttsState == TtsState.playing) {
      await stop();
    } else {
      for (int i = playingLine - 1; i < lines.length; i++) {
        await _speak(lines.entries.toList()[i].value);
        playingLine = i + 2;
      }
      await stop();
    }
    notifyListeners();
  }

  Future<void> stop() async {
    final res = await tts.stop();
    if (res == 1) {
      playingLine = 1;
      ttsState = TtsState.stopped;
      notifyListeners();
    }
  }
}
