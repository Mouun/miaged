import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constants.dart';

class AuthentifiedAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final AppBar appBar = new AppBar();
  final String title;
  final bool showRightActionButton;
  final String rightActionButtonText;
  final VoidCallback rightActionButtonOnPressed;

  AuthentifiedAppBar(
      {@required this.title,
      this.showRightActionButton = false,
      this.rightActionButtonText,
      this.rightActionButtonOnPressed});

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.montserrat(
          color: kMainColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevation: 0,
      iconTheme: IconThemeData(
        color: kMainColor, //change your color here
      ),
      backgroundColor: Colors.white,
      actions: showRightActionButton
          ? [
              FlatButton(
                onPressed: rightActionButtonOnPressed,
                child: Text(
                  rightActionButtonText,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]
          : [],
    );
  }
}
