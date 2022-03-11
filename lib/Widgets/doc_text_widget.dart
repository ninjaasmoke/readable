import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readable/Providers/pdf_provider.dart';
import 'package:readable/constants.dart';
import 'package:readable/Models/doc_model.dart' as doc_model;

class DocTextWidget extends StatelessWidget {
  const DocTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doc_model.Doc doc = Provider.of<PdfProvider>(context).doc;
    return Scaffold(
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
            children: doc.pages.map((page) {
              return DocPage(
                page: page,
              );
            }).toList(),
          ),
        ),
      ),
      bottomNavigationBar: const Controls(),
    );
  }
}

class DocPage extends StatelessWidget {
  final doc_model.Page page;
  const DocPage({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int selectedPage = 1;
    const int selectedLine = 2;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            page.pageNum.toString(),
            style: const TextStyle(fontSize: 14, color: Color(ACCENT_COLOR)),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: page.lines!.entries.map((entry) {
              return PageText(
                text: entry.value + ".",
                isSelected:
                    entry.key == selectedLine && selectedPage == page.pageNum,
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class PageText extends StatelessWidget {
  final String text;
  final bool isSelected;
  const PageText({
    Key? key,
    required this.text,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        height: 1.1,
        fontSize: isSelected ? 28 : 18,
        color: isSelected ? const Color(ACCENT_COLOR) : Colors.white,
      ),
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      padding: const EdgeInsets.all(20),
    );
  }
}
