import 'package:get_it/get_it.dart';
import 'package:miaged/services/app_users.service.dart';
import 'package:miaged/services/auth.service.dart';
import 'package:miaged/services/carts.service.dart';
import 'package:miaged/services/categories.service.dart';
import 'package:miaged/services/products.service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(AuthService());
  locator.registerSingleton(ProductsService());
  locator.registerSingleton(CategoriesService());
  locator.registerSingleton(AppUsersService());
  locator.registerSingleton(CartsService());
}
