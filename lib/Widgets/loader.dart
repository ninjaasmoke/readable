import 'package:flutter/material.dart';
import 'package:readable/constants.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(ACCENT_COLOR)),
      ),
    );
  }
}
