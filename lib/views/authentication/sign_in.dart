import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/extensions/string.extension.dart';
import 'package:miaged/locators.dart';
import 'package:miaged/services/auth.service.dart';
import 'package:miaged/widgets/custom_button.dart';
import 'package:miaged/widgets/custom_button_empty.dart';
import 'package:miaged/widgets/unauthentified_appbar.dart';

class SignInPage extends StatelessWidget {
  final _authService = locator<AuthService>();
  final _formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UnauthentifiedAppBar(),
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
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
              ),
              TextFormField(
                controller: loginController,
                decoration: InputDecoration(labelText: 'Login'),
                validator: (value) {
                  if (value.isEmpty) return 'Le login est obligatoire';
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
                          loginController.value.text,
                          passwordController.value.text);
                      if (result != null) {
                        Navigator.pushReplacementNamed(context, '/shop');
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Erreur',
                                style: GoogleFonts.montserrat(),
                              ),
                              content: Text(
                                'Aucun compte ne correspond aux informations que vous avez saisies',
                                style: GoogleFonts.lato(),
                              ),
                              actions: [
                                FlatButton(
                                  child: Text(
                                    'Ok',
                                    style: GoogleFonts.lato(color: kMainColor),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          },
                        );
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
