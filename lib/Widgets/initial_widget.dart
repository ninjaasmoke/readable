import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:readable/Pages/settings_page.dart';
import 'package:readable/Providers/pdf_provider.dart';
import 'package:readable/constants.dart';

class InitialWidget extends StatelessWidget {
  const InitialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(),
        SizedBox(
          height: 160,
          child: SvgPicture.asset('assets/Images/toy.svg'),
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
                    color: Color(ACCENT_COLOR),
                  ),
                ),
              ],
            ),
          ),
        ),
        const InstructionSteps(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.info_outline),
              iconSize: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  backgroundColor: const Color(ACCENT_COLOR),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  )),
              onPressed:
                  Provider.of<PdfProvider>(context, listen: false).pickPdf,
              child: const Text(
                "Pick PDF",
                style: TextStyle(
                    color: Color(DEFAULT_TEXT_COLOR),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  fullscreenDialog: false,
                  builder: (context) => const SettingsPage(),
                ),
              ),
              icon: const Icon(Icons.settings),
              iconSize: 20,
            ),
          ],
        ),
      ],
    );
  }
}

class InstructionSteps extends StatelessWidget {
  const InstructionSteps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("∘ Click on the button below",
              style: TextStyle(fontSize: 20)),
          const Text("∘ Pick a PDF file", style: TextStyle(fontSize: 20)),
          const Text("∘ Enjoy", style: TextStyle(fontSize: 20)),
          const SizedBox(
            height: 20,
          ),
          Text(
            Provider.of<PdfProvider>(context).errorText ?? "",
            style: const TextStyle(color: Color(ACCENT_COLOR)),
          )
        ],
      ),
    );
  }
}
