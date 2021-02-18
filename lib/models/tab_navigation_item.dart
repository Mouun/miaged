import 'package:flutter/material.dart';
import 'package:miaged/views/shop.dart';
import 'package:miaged/views/shopping_cart.dart';
import 'package:miaged/views/user_profile.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem({@required this.page, @required this.title, @required this.icon});

  static List<TabNavigationItem> get bottomNavigationItems => [
        TabNavigationItem(page: ShopPage(), title: 'Acheter', icon: Icon(Icons.attach_money)),
        TabNavigationItem(page: ShoppingCartPage(), title: 'Panier', icon: Icon(Icons.shopping_basket)),
        TabNavigationItem(page: UserProfilePage(), title: 'Profil', icon: Icon(Icons.person))
      ];
}
