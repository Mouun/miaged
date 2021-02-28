import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUsersService {
  Future<String> getAppUserFirebaseRef() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('UID');
  }

  Future<AppUser> getAppUser({String appUserRef = ''}) async {
    String firebaseRef = await getAppUserFirebaseRef();

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection(kUsersCollectionName)
        .doc(appUserRef.isNotEmpty ? appUserRef : firebaseRef)
        .get();

    return AppUser.fromSnap(userSnapshot);
  }

  Future<void> updateAppUserInfo(AppUser newAppUser) async {
    String firebaseRef = await getAppUserFirebaseRef();

    await FirebaseFirestore.instance
        .collection(kUsersCollectionName)
        .doc(firebaseRef)
        .update(
      {
        'password': newAppUser.password,
        'birthday': newAppUser.birthdate,
        'address': newAppUser.address,
        'postalCode': newAppUser.postalCode,
        'city': newAppUser.city,
      },
    );
  }
}
