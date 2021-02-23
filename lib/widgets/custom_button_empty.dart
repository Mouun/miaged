import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class CustomButtonEmpty extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButtonEmpty({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      height: 42,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: kMainColor),
      ),
      color: Colors.white,
      child: Text(
        text,
        style: GoogleFonts.lato(
          color: kMainColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
