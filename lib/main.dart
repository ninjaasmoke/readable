import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:readable/Providers/pdf_provider.dart';
import 'package:readable/Providers/tts_provider.dart';
import 'package:readable/Widgets/wrapper.dart';
import 'package:readable/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PdfProvider>(create: (context) => PdfProvider()),
        ChangeNotifierProxyProvider<PdfProvider, TtsProvider>(
          create: (context) => TtsProvider(),
          update: (context, pdfProvider, ttsProvider) =>
              ttsProvider!..lines = pdfProvider.doc.lines,
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Readable',
          themeMode: ThemeMode.dark,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.black,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            child: Wrapper(),
          ),
        );
      },
    );
  }
}
