import 'package:pdf_text/pdf_text.dart';

class Page {
  Map<int, String>? lines;
  late int pageNum;

  Page({required this.pageNum, this.lines});
}

class Doc {
  List<Page> pages = [];

  Future<void> addPages(List<PDFPage> pdfPages) async {
    for (var pdfPage in pdfPages) {
      final text = await pdfPage.text;
      final linesList = text
          .replaceAll(RegExp(r'\n'), ' ')
          .replaceAll(RegExp(r'•'), '\n')
          .split('. ')
          .map((e) => e.trim().replaceAll(RegExp(r'\.'), '. '))
          .toList();
      final page = Page(
        pageNum: pdfPage.number,
        lines: linesList.asMap(),
      );
      pages.add(page);
    }
  }

  void clear() {
    pages.clear();
  }
}
