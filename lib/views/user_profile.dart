import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miaged/models/app_user.dart';
import 'package:miaged/services/app_users.service.dart';
import 'package:miaged/services/auth.service.dart';
import 'package:miaged/views/change_password.dart';
import 'package:miaged/widgets/authentified_appbar.dart';
import 'package:miaged/widgets/custom_button.dart';
import 'package:miaged/widgets/custom_button_empty.dart';
import 'package:miaged/widgets/loading_indicator.dart';

import '../constants.dart';
import '../locators.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Future<AppUser> userInfo;
  AppUser initialUserInfo;
  AppUsersService _appUsersService = locator<AppUsersService>();
  AuthService _authService = locator<AuthService>();

  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate;
  TextEditingController birthdayController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  void _showDatePicker(BuildContext context, DateTime initialDate) async {
    DateTime datePicked = await showDatePicker(
      context: context,
      initialDate: selectedDate != null ? selectedDate : initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year - 12),
      builder: (BuildContext context, Widget datePicker) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: kMainColor,
              onPrimary: Colors.white,
              surface: kMainColor,
              onSurface: kTextDefaultColor,
            ),
            primaryColor: kMainColor,
            dialogBackgroundColor: Colors.white,
          ),
          child: datePicker,
        );
      },
    );
    if (datePicked != null) selectedDate = datePicked;
    birthdayController.text = getFormattedDate(selectedDate);
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  Future<AppUser> fetchUserInfo() async {
    AppUser userInfo = await _appUsersService.getAppUser();

    selectedDate = userInfo.birthdate.toDate();

    birthdayController.text = getFormattedDate(userInfo.birthdate.toDate());
    addressController.text = userInfo.address;
    postalCodeController.text = userInfo.postalCode;
    cityController.text = userInfo.city;

    initialUserInfo = userInfo;

    return userInfo;
  }

  @override
  void initState() {
    userInfo = fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AuthentifiedAppBar(
        title: 'Profil',
        showRightActionButton: true,
        rightActionButtonText: 'Valider',
        rightActionButtonOnPressed: () async {
          if (_formKey.currentState.validate()) {
            await _appUsersService.updateAppUserInfo(
              AppUser(
                firebaseRef: initialUserInfo.firebaseRef,
                birthdate: Timestamp.fromDate(selectedDate),
                address: addressController.value.text,
                postalCode: postalCodeController.value.text,
                city: cityController.value.text,
              ),
            );
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Votre profil a été mis à jour avec succés',
                ),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
      ),
      body: FutureBuilder<AppUser>(
        future: userInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
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
                              initialValue: snapshot.data.email,
                              decoration: InputDecoration(labelText: 'Email'),
                              readOnly: true,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'L\'adresse email est requise';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: birthdayController,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Anniversaire',
                              ),
                              onTap: () {
                                _showDatePicker(
                                  context,
                                  snapshot.data.birthdate.toDate(),
                                );
                              },
                            ),
                            TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(
                                labelText: 'Adresse',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'L\'adresse est requise';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: postalCodeController,
                              decoration: InputDecoration(
                                labelText: 'Code postal',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Le code postal est requis';
                                }
                                if (value.length != 5) {
                                  return 'Le code postal doit faire 5 caractères';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: cityController,
                              decoration: InputDecoration(
                                labelText: 'Ville',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'La ville est requise';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: kDefaultPadding / 2),
                      child: CustomButtonEmpty(
                        text: 'Changer le mot de passe',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePassword()),
                          );
                        },
                      ),
                    ),
                    CustomButton(
                      text: 'Se déconnecter',
                      onPressed: () async {
                        await _authService.signOut();
                        Navigator.pushReplacementNamed(context, '/sign-in');
                      },
                      danger: true,
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
