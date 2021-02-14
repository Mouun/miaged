import 'package:flutter/material.dart';
import 'package:miaged/extensions/string.extension.dart';
import 'package:miaged/locators.dart';
import 'package:miaged/services/auth.service.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  final _authService = locator<AuthService>();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MIAGED')),
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Se connecter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) return 'L\'adresse email est obligatoire';
                  if (!value.isValidEmailAddress()) return 'L\'adresse email n\'est pas valide';
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Mot de passe'),
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value.isEmpty) return 'Le mot de passe est obligatoire';
                  if (!value.isValidPassword()) return 'Le mot de passe doit faire au moins de 6 caractères';
                  return null;
                },
              ),
            ),
            RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    var result = await _authService.signIn(emailController.value.text, passwordController.value.text);
                    if (result != null) {
                      Navigator.pushReplacementNamed(context, '/feed');
                    }
                  }
                },
                child: Text('Se connecter')),
            OutlineButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-up');
                },
                child: Text('S\'inscrire'))
          ],
        ),
      ),
    );
  }
}
