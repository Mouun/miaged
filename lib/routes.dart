import 'package:miaged/views/authentication/sign_in.dart';
import 'package:miaged/views/authentication/sign_up.dart';
import 'package:miaged/views/offers_list_page.dart';

final routes = {
  '/sign-in': (context) => new SignInPage(),
  '/feed': (context) => new OffersListPage(),
  '/sign-up': (context) => new SignUpPage()
};
