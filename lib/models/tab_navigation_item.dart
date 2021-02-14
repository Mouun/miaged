import 'package:flutter/material.dart';
import 'file:///D:/Dev/miaged/lib/views/offers_list_page.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem({@required this.page, @required this.title, @required this.icon});

  static List<TabNavigationItem> get bottomNavigationItems => [
        TabNavigationItem(page: OffersListPage(), title: 'Acheter', icon: Icon(Icons.shopping_basket)),
        TabNavigationItem(page: OffersListPage(), title: 'Panier', icon: Icon(Icons.shopping_basket)),
        TabNavigationItem(page: OffersListPage(), title: 'Profil', icon: Icon(Icons.shopping_basket))
      ];
}
