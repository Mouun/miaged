import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/app_user.dart';

class AppUsersService {
  Future<AppUser> getAppUser() async {
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection(kUsersCollectionName)
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();

    AppUser finalUser = userSnapshot.docs
        .map((userApp) => AppUser.fromSnap(userApp, userApp.id))
        .toList()[0];

    return finalUser;
  }

  Future<void> updateAppUserInfo(AppUser newAppUser) async {
    await FirebaseFirestore.instance
        .collection(kUsersCollectionName)
        .doc(newAppUser.firebaseRef)
        .update(
      {
        'birthday': newAppUser.birthdate,
        'address': newAppUser.address,
        'postalCode': newAppUser.postalCode,
        'city': newAppUser.city,
      },
    );
  }
}
