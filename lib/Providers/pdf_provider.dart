import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:readable/Models/doc_model.dart' as doc_model;

class PdfProvider extends ChangeNotifier {
  File? file;
  PDFDoc? pdfDoc;
  String? docText;
  List<PDFPage>? pages;

  doc_model.Doc doc = doc_model.Doc();

  bool isBusy = false;
  String? errorText;

  void setBusy(bool value) {
    isBusy = value;
    notifyListeners();
  }

  void _setError(String? error) {
    errorText = error;
    notifyListeners();
  }

  Future<void> pickPdf() async {
    setBusy(true);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        file = File(result.files.single.path!);
        pdfDoc = await PDFDoc.fromFile(file!);
        docText = await pdfDoc!.text;
        doc.addLines(docText!);
        setBusy(false);
      } else {
        _setError('You did not pick a PDF! Please try again.');
        setBusy(false);
      }
    } catch (e) {
      _setError("Unable to load PDF!");
      setBusy(false);
    } finally {
      notifyListeners();
    }
  }

  void closePdf() {
    setBusy(true);
    file = null;
    pdfDoc = null;
    docText = null;
    pages = null;
    errorText = null;
    doc.clear();
    setBusy(false);
    notifyListeners();
  }
}
