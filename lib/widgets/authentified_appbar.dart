import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/locators.dart';
import 'package:miaged/services/auth.service.dart';

class AuthentifiedAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final _authService = locator<AuthService>();
  final AppBar appBar = new AppBar();
  final String title;

  AuthentifiedAppBar({@required this.title});

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
      backgroundColor: Colors.white,
      actionsIconTheme: IconThemeData(color: kTextDefaultColor),
      actions: [
        PopupMenuButton<String>(
          onSelected: (choice) => handlePopupMenuItemClick(choice, context),
          itemBuilder: (BuildContext context) {
            return {'Se déconnecter'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        )
      ],
    );
  }

  void handlePopupMenuItemClick(String value, BuildContext context) async {
    switch (value) {
      case 'Se déconnecter':
        await _authService.signOut();
        Navigator.pushReplacementNamed(context, '/sign-in');
    }
  }
}
