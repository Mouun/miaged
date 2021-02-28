import 'package:flutter/material.dart';
import 'package:miaged/extensions/string.extension.dart';
import 'package:miaged/locators.dart';
import 'package:miaged/services/auth.service.dart';
import 'package:miaged/widgets/custom_button.dart';
import 'package:miaged/widgets/custom_button_empty.dart';

import '../../constants.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'S\'inscrire',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
              ),
            ),
            TextFormField(
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
            Padding(
              padding: EdgeInsets.only(
                top: kDefaultPadding * 2,
                bottom: 16,
              ),
              child: CustomButton(
                text: 'S\'inscrire',
                onPressed: () async {
                  await _authService.signUp(
                      emailController.text, passwordController.text);
                },
              ),
            ),
            CustomButtonEmpty(
              text: 'Se connecter',
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
