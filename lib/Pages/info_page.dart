import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Something will come here, maybe...',
              style: TextStyle(
                fontSize: 48,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextButton.icon(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(20),
            ),
            onPressed: Navigator.of(context).pop,
            label: const Text(
              "Back",
            ),
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
