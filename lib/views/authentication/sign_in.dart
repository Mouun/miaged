import 'package:flutter/material.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/extensions/string.extension.dart';
import 'package:miaged/locators.dart';
import 'package:miaged/services/auth.service.dart';
import 'package:miaged/widgets/custom_button.dart';
import 'package:miaged/widgets/custom_button_empty.dart';

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
      body: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Se connecter',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty)
                    return 'L\'adresse email est obligatoire';
                  if (!value.isValidEmailAddress())
                    return 'L\'adresse email n\'est pas valide';
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Mot de passe'),
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value.isEmpty) return 'Le mot de passe est obligatoire';
                  if (!value.isValidPassword())
                    return 'Le mot de passe doit faire au moins de 6 caractères';
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: kDefaultPadding * 2,
                  bottom: 16,
                ),
                child: CustomButton(
                  text: 'Se connecter',
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var result = await _authService.signIn(
                          emailController.value.text,
                          passwordController.value.text);
                      if (result != null) {
                        Navigator.pushReplacementNamed(context, '/shop');
                      }
                    }
                  },
                ),
              ),
              CustomButtonEmpty(
                text: 'S\'inscrire',
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-up');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
