import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/locators.dart';
import 'package:miaged/routes.dart';
import 'package:miaged/widgets/loading_indicator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var initialRoute = '/sign-in';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder(
      future: initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.hasData) initialRoute = '/shop';
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            supportedLocales: [
              const Locale('fr', 'FR'),
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: kMainColor,
              accentColor: kMainColor,
              textTheme: GoogleFonts.latoTextTheme(
                textTheme,
              ).copyWith(
                bodyText2: TextStyle(color: kTextDefaultColor),
              ),
            ),
            initialRoute: initialRoute,
            routes: routes,
          );
        }
        return LoadingIndicator();
      },
    );
  }

  Future<User> initializeFirebase() async {
    await Firebase.initializeApp();
    return FirebaseAuth.instance.currentUser;
  }
}
