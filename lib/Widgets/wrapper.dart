import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readable/Providers/pdf_provider.dart';
import 'package:readable/Widgets/doc_text_widget.dart';
import 'package:readable/Widgets/initial_widget.dart';
import 'package:readable/Widgets/loader.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getMainWidget(context),
    );
  }
}

Widget getMainWidget(BuildContext context) {
  if (Provider.of<PdfProvider>(context).isBusy) {
    return const Loader();
  }
  if (Provider.of<PdfProvider>(context).docText == null) {
    return const InitialWidget();
  }
  return const DocTextWidget();
}
