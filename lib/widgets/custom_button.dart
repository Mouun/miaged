import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      height: 42,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      color: kMainColor,
      child: Text(
        text,
        style: GoogleFonts.lato(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
