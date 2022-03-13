import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readable/Providers/pdf_provider.dart';
import 'package:readable/Providers/tts_provider.dart';
import 'package:readable/constants.dart';
import 'package:readable/Models/doc_model.dart' as doc_model;

class DocTextWidget extends StatelessWidget {
  const DocTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doc_model.Doc doc = Provider.of<PdfProvider>(context).doc;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Readable',
              style: TextStyle(color: Color(ACCENT_COLOR), fontSize: 16),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                iconSize: 18,
                onPressed:
                    Provider.of<PdfProvider>(context, listen: false).closePdf,
              ),
            ],
          ),
          body: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: doc.lines.entries.map((line) {
                  return PageText(
                    text: line.value,
                    id: line.key,
                    isSelected: line.key ==
                        Provider.of<TtsProvider>(context).playingLine,
                  );
                }).toList(),
              ),
            ),
          ),
          bottomNavigationBar: const Controls(),
        ),
        onWillPop: () {
          Provider.of<PdfProvider>(context, listen: false).closePdf();
          return Future.value(false);
        });
  }
}

class PageText extends StatelessWidget {
  final String text;
  final int id;
  final bool isSelected;
  const PageText({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('$id'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      child: Text(
        text,
        style: TextStyle(
          height: 1.1,
          fontSize: isSelected ? 28 : 18,
          color: isSelected ? const Color(ACCENT_COLOR) : Colors.white,
        ),
      ),
    );
  }
}

class Controls extends StatefulWidget {
  const Controls({Key? key}) : super(key: key);

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls>
    with SingleTickerProviderStateMixin {
  late AnimationController progressAnimation;
  @override
  void initState() {
    progressAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  void _handleOnPressed(ttsState) {
    setState(() {
      ttsState == TtsState.playing
          ? progressAnimation.forward()
          : progressAnimation.reverse();
    });
  }

  @override
  void dispose() {
    progressAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TtsState ttsState = Provider.of<TtsProvider>(context).ttsState;
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.all(20),
      child: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: progressAnimation,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => _handleOnPressed(ttsState),
      ),
    );
  }
}
