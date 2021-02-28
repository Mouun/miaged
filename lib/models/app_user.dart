import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String login;
  final String password;
  final String address;
  final String postalCode;
  final String city;
  final Timestamp birthdate;

  AppUser({
    this.login,
    this.password,
    this.address,
    this.postalCode,
    this.city,
    this.birthdate,
  });

  factory AppUser.fromSnap(DocumentSnapshot appUserSnap) {
    return AppUser(
      login: appUserSnap.data()['login'],
      password: appUserSnap.data()['password'],
      address: appUserSnap.data()['address'],
      postalCode: appUserSnap.data()['postalCode'],
      city: appUserSnap.data()['city'],
      birthdate: appUserSnap.data()['birthday'],
    );
  }
}
