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
          body: SafeArea(
            child: Scrollbar(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final entry = doc.lines;
                        return PageText(
                          text: entry[index + 1]!,
                          id: index + 1,
                          isSelected: (index + 1) ==
                              Provider.of<TtsProvider>(context).playingLine,
                        );
                      },
                      childCount: doc.lines.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const Controls(),
        ),
        onWillPop: () {
          Provider.of<PdfProvider>(context, listen: false).closePdf();
          Provider.of<TtsProvider>(context, listen: false).reset();
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
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 100),
        style: TextStyle(
          height: 1.1,
          fontFamily: FONT_NAME,
          fontSize: isSelected ? 22 : 20,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.white : Colors.grey[400],
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TtsState ttsState = Provider.of<TtsProvider>(context).ttsState;
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: Color(ACCENT_COLOR),
                  ),
                ),
                onPressed: () {
                  Provider.of<PdfProvider>(context, listen: false).closePdf();
                  Provider.of<TtsProvider>(context, listen: false).reset();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed:
                    Provider.of<TtsProvider>(context, listen: false).rewind,
                iconSize: 20,
                icon: const Icon(Icons.fast_rewind),
              ),
              IconButton(
                icon: Icon(
                  ttsState == TtsState.playing ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed:
                    Provider.of<TtsProvider>(context, listen: false).playPause,
              ),
              IconButton(
                onPressed: Provider.of<TtsProvider>(context, listen: false)
                    .fastForward,
                iconSize: 20,
                icon: const Icon(Icons.fast_forward),
              ),
            ],
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
