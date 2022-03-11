import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
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
        SizedBox(
          height: 160,
          child: SvgPicture.asset('assets/Images/toy.svg'),
        ),
        const InstructionSteps(),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              backgroundColor: const Color(ACCENT_COLOR),
            ),
            onPressed: Provider.of<PdfProvider>(context, listen: false).pickPdf,
            child: const Text(
              "Pick PDF",
              style: TextStyle(
                  color: Color(DEFAULT_TEXT_COLOR),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
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
