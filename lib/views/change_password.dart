import 'package:flutter/material.dart';
import 'package:miaged/extensions/string.extension.dart';
import 'package:miaged/widgets/authentified_appbar.dart';
import 'package:miaged/widgets/custom_button.dart';

import '../constants.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AuthentifiedAppBar(title: 'Mot de passe'),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding - 8,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: kDefaultPadding * 2),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                        ),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Le mot de passe est requis';
                          if (!value.isValidPassword())
                            return 'Le mot de passe doit faire au moins de 6 caractères';
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: kDefaultPadding * 2,
                        ),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirmation du mot de passe',
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Le mot de passe de confirmation est requis';
                            if (!value.isValidPassword())
                              return 'Le mot de passe doit faire au moins de 6 caractères';
                            if (value != passwordController.value.text)
                              return 'Le mot de passe et le mot de passe de confirmation doivent être identiques';
                            return null;
                          },
                        ),
                      ),
                      CustomButton(
                        text: 'Valider',
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            print('ok');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
