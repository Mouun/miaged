import 'package:get_it/get_it.dart';
import 'package:miaged/services/auth.service.dart';
import 'package:miaged/services/products.service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(AuthService());
  locator.registerSingleton(ProductsService());
}
