import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readable/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Readable',
      themeMode: ThemeMode.dark,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Product',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Hi, welcome to',
                        style: TextStyle(
                          fontSize: 38,
                        ),
                      ),
                      TextSpan(
                        text: ' Readable',
                        style: TextStyle(
                          fontSize: 38,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
