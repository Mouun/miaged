import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/locators.dart';
import 'package:miaged/routes.dart';
import 'package:miaged/services/app_users.service.dart';
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
  AppUsersService _appUsersService = locator<AppUsersService>();

  var initialRoute = '/sign-in';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder(
      future: initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) initialRoute = '/shop';
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
              cursorColor: kMainColor,
              textTheme: GoogleFonts.latoTextTheme(
                textTheme,
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

  Future<String> initializeApp() async {
    await Firebase.initializeApp();
    return _appUsersService.getAppUserFirebaseRef();
  }
}
