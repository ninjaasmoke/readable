import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readable/Models/voice_model.dart';
import 'package:readable/Providers/tts_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Voice> voices =
        Provider.of<TtsProvider>(context).availableVoices;
    final currentVoice = Provider.of<TtsProvider>(context).currentVoice;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Choose Voice'),
              ),
              DropdownButton<String>(
                value: currentVoice.name,
                onChanged: (value) {
                  Provider.of<TtsProvider>(context, listen: false).setVoice(
                    voices.firstWhere((element) => element.name == value),
                  );
                },
                items: voices.map((value) {
                  return DropdownMenuItem<String>(
                    value: value.name,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
