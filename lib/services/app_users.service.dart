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

    AppUser finalUser =
        userSnapshot.docs.map((userApp) => AppUser.fromSnap(userApp)).toList()[0];

    return finalUser;
  }
}
