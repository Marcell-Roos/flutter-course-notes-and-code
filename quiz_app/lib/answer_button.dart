import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(
            255,
            44,
            6,
            96,
          ),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 40,
          ),
        ),
        child: Text(
          answerText,
          textAlign: TextAlign.center,
          // style: GoogleFonts.lato(
          //   color: Colors.white,
          //   fontSize: 24,
          // ),
        ),
      ),
    );
  }
}
