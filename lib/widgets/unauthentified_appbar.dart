import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constants.dart';

class UnauthentifiedAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final AppBar appBar = new AppBar();

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'MIAGED',
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor: kMainColor,
    );
  }
}
