import 'package:flutter/material.dart';
import 'package:miaged/widgets/authentified_appbar.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthentifiedAppBar(title: 'Profil'),
      body: Center(
        child: Text('Profil Utilisateur', style: TextStyle(fontSize: 30)),
      ),
    );
  }
}
