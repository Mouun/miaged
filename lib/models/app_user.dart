import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {

  final String uid;
  final String email;
  final String address;
  final String postalCode;
  final String city;
  final Timestamp birthdate;

  AppUser({
    this.uid,
    this.email,
    this.address,
    this.postalCode,
    this.city,
    this.birthdate,
  });

  factory AppUser.fromSnap(QueryDocumentSnapshot appUserSnap) {
    return AppUser(
      uid: appUserSnap.data()['uid'],
      email: appUserSnap.data()['email'],
      address: appUserSnap.data()['address'],
      postalCode: appUserSnap.data()['postalCode'],
      city: appUserSnap.data()['city'],
      birthdate: appUserSnap.data()['birthday'],
    );
  }
}
