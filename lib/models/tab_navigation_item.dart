import 'package:flutter/material.dart';
import 'package:miaged/views/shop/shop.dart';
import 'package:miaged/views/shopping_cart.dart';
import 'package:miaged/views/user_profile.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;
  final Icon activeIcon;

  TabNavigationItem({@required this.page, @required this.title, @required this.icon, @required this.activeIcon});

  static List<TabNavigationItem> get bottomNavigationItems => [
        TabNavigationItem(
          page: ShopPage(),
          title: 'Acheter',
          icon: Icon(Icons.attach_money_outlined),
          activeIcon: Icon(Icons.attach_money)
        ),
        TabNavigationItem(
          page: ShoppingCartPage(),
          title: 'Panier',
          icon: Icon(Icons.shopping_basket_outlined),
          activeIcon: Icon(Icons.shopping_basket)
        ),
        TabNavigationItem(
          page: UserProfilePage(),
          title: 'Profil',
          icon: Icon(Icons.person_outlined),
          activeIcon: Icon(Icons.person)
        )
      ];
}
