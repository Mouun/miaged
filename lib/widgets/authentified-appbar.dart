import 'package:flutter/material.dart';
import 'package:miaged/locators.dart';
import 'package:miaged/services/auth.service.dart';

class AuthentifiedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final _authService = locator<AuthService>();
  final AppBar appBar = new AppBar();
  final String title;

  AuthentifiedAppBar({@required this.title});

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title), actions: [
      PopupMenuButton<String>(
        onSelected: (choice) => handlePopupMenuItemClick(choice, context),
        itemBuilder: (BuildContext context) {
          return {'Paramètres', 'Se déconnecter'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      )
    ]);
  }

  void handlePopupMenuItemClick(String value, BuildContext context) async {
    switch (value) {
      case 'Paramètres':
        break;
      case 'Se déconnecter':
        await _authService.signOut();
        Navigator.pushReplacementNamed(context, '/sign-in');
    }
  }
}
