import 'package:flutter/material.dart';
import 'package:miaged/extensions/string.extension.dart';
import 'package:miaged/locators.dart';
import 'package:miaged/services/auth.service.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _authService = locator<AuthService>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MIAGED')),
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'S\'inscrire',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirmation du mot de passe',
              ),
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value.isEmpty)
                  return 'Le mot de passe de confirmation est obligatoire';
                if (!value.isValidPassword())
                  return 'Le mot de passe doit faire au moins de 6 caractères';
                if (value != passwordController.value.text)
                  return 'Le mot de passe et le mot de passe de confirmation doivent être identiques';
                return null;
              },
            ),
          ),
          RaisedButton(
            onPressed: () async {
              await _authService.signUp(
                  emailController.text, passwordController.text);
            },
            child: Text(
              'S\'inscrire',
            ),
          ),
          OutlineButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            child: Text(
              'Déjà inscrit ? Se connecter',
            ),
          )
        ],
      ),
    );
  }
}
