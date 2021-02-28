import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/app_user.dart';
import 'package:miaged/services/app_users.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../locators.dart';

class AuthService {
  Future<AppUser> signUp(String login, String password) async {
    AppUsersService _appUsersService = locator<AppUsersService>();

    DocumentReference newAppUser =
        await FirebaseFirestore.instance.collection(kUsersCollectionName).add(
      {
        'login': login,
        'password': password,
        'birthday': Timestamp.fromDate(DateTime(1900)),
        'address': '',
        'postalCode': '',
        'city': '',
      },
    );

    if (newAppUser != null) {
      await FirebaseFirestore.instance.collection(kCartCollectionName).add(
        {
          'uid': newAppUser.id,
          'products': [],
        },
      );

      return _appUsersService.getAppUser(appUserRef: newAppUser.id);
    }
    return null;
  }

  Future<AppUser> signIn(String login, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    QuerySnapshot appUserSnapshot = await FirebaseFirestore.instance
        .collection(kUsersCollectionName)
        .where('login', isEqualTo: login)
        .where('password', isEqualTo: password)
        .get();

    if (appUserSnapshot.docs.isEmpty) {
      return null;
    }

    prefs.setString('UID', appUserSnapshot.docs.first.id);

    return AppUser.fromSnap(appUserSnapshot.docs.first);
  }

  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
