import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';
import 'package:readable/Models/voice_model.dart';

enum TtsState { playing, stopped }

class TtsProvider extends ChangeNotifier {
  FlutterTts tts = FlutterTts();
  Map<int, String> lines = Map.from({});
  TtsState ttsState = TtsState.stopped;

  final List<Voice> _availableVoices = <Voice>[];
  List<Voice> get availableVoices => _availableVoices;

  final box = Hive.box('voice');

  Voice currentVoice = Voice(
    name: 'es-us-x-sfb-local',
    locale: 'en-US',
  );

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

    setInitVoice();

    loadVoices();
  }

  void setInitVoice() async {
    final name = box.get('name');
    final locale = box.get('locale');
    final Voice voice = Voice(
      name: name ?? 'es-us-x-sfb-local',
      locale: locale ?? 'en-US',
    );
    setVoice(voice);
  }

  void setVoice(Voice voice) {
    box.putAll({
      'name': voice.name,
      'locale': voice.locale,
    });
    currentVoice = voice;
    tts.setVoice(currentVoice.toJson());
    notifyListeners();
  }

  Future<void> loadVoices() async {
    final voices = await tts.getVoices;
    for (final voice in voices) {
      _availableVoices.add(Voice.fromJson(json.decode(jsonEncode(voice))));
    }
    notifyListeners();
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

  Future<void> increaseRate() async {
    _rate += 0.1;
    if (ttsState == TtsState.playing) {
      await stop();
      tts.setSpeechRate(_rate);
      await playPause();
    } else {
      tts.setSpeechRate(_rate);
      notifyListeners();
    }
  }

  Future<void> decreaseRate() async {
    _rate -= 0.1;
    if (ttsState == TtsState.playing) {
      await stop();
      tts.setSpeechRate(_rate);
      await playPause();
    } else {
      tts.setSpeechRate(_rate);
      notifyListeners();
    }
  }

  Future<void> _speak(String text) async {
    await tts.awaitSpeakCompletion(true);
    await tts.awaitSynthCompletion(true);
    final res = await tts.speak(text);
  }

  Future<void> playPause() async {
    if (ttsState == TtsState.playing) {
      await stop();
    } else {
      ttsState = TtsState.playing;
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
