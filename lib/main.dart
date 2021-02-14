import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miaged/locators.dart';
import 'package:miaged/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var initialRoute = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.hasData) initialRoute = '/feed';
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            initialRoute: initialRoute,
            routes: routes,
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<User> initializeFirebase() async {
    await Firebase.initializeApp();
    return FirebaseAuth.instance.currentUser;
  }
}


