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
    tts.setVoice({"name": "en-gb-x-gbd-local", "locale": "en-GB"});
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
    work();
  }

  Future<void> work() async {
    print("Engines: ${await tts.getVoices}");
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
      await reset();
    }
  }

  Future<void> stop() async {
    final res = await tts.stop();
    if (res == 1) {
      ttsState = TtsState.stopped;
      notifyListeners();
    }
  }

  Future<void> reset() async {
    await stop();
    playingLine = 1;
    ttsState = TtsState.stopped;
    notifyListeners();
  }

  Future<void> fastForward() async {
    if (playingLine < lines.length) {
      await stop();
      playingLine++;
      await playPause();
    }
  }

  Future<void> rewind() async {
    if (playingLine > 1) {
      await stop();
      playingLine--;
      await playPause();
    }
  }
}
