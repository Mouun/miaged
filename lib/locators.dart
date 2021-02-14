import 'package:get_it/get_it.dart';
import 'package:miaged/services/auth.service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(AuthService());
}
