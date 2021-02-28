import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/extensions/string.extension.dart';
import 'package:miaged/locators.dart';
import 'package:miaged/models/app_user.dart';
import 'package:miaged/services/auth.service.dart';
import 'package:miaged/widgets/custom_button.dart';
import 'package:miaged/widgets/custom_button_empty.dart';
import 'package:miaged/widgets/unauthentified_appbar.dart';

import '../../constants.dart';

class SignUpPage extends StatelessWidget {
  final _authService = locator<AuthService>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UnauthentifiedAppBar(),
      resizeToAvoidBottomPadding: false,
      body: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'S\'inscrire',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                ),
                TextFormField(
                  controller: loginController,
                  decoration: InputDecoration(
                    labelText: 'Login',
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Le login est obligatoire';
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Le mot de passe est obligatoire';
                    if (!value.isValidPassword())
                      return 'Le mot de passe doit faire au moins 6 caractères';
                    return null;
                  },
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
                      return 'Le mot de passe de confirmation doit faire au moins de 6 caractères';
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
                      if (_formKey.currentState.validate()) {
                        AppUser newAppUser = await _authService.signUp(
                            loginController.text, passwordController.text);
                        if (newAppUser != null) {
                          Navigator.pop(
                            context,
                          );
                        }
                      }
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
          )),
    );
  }
}
