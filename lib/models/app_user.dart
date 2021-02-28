import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String firebaseRef;
  final String uid;
  final String email;
  final String address;
  final String postalCode;
  final String city;
  final Timestamp birthdate;

  AppUser({
    this.firebaseRef,
    this.uid,
    this.email,
    this.address,
    this.postalCode,
    this.city,
    this.birthdate,
  });

  factory AppUser.fromSnap(QueryDocumentSnapshot appUserSnap, String firebaseRef) {
    return AppUser(
      firebaseRef: firebaseRef,
      uid: appUserSnap.data()['uid'],
      email: appUserSnap.data()['email'],
      address: appUserSnap.data()['address'],
      postalCode: appUserSnap.data()['postalCode'],
      city: appUserSnap.data()['city'],
      birthdate: appUserSnap.data()['birthday'],
    );
  }
}
