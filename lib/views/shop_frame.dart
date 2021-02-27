import 'package:flutter/material.dart';
import 'package:miaged/views/shop.dart';
import 'package:miaged/views/shopping_cart.dart';
import 'package:miaged/views/user_profile.dart';
import '../constants.dart';

class ShopFrame extends StatefulWidget {
  @override
  _ShopFrameState createState() => _ShopFrameState();
}

class _ShopFrameState extends State<ShopFrame> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          TabNavigationItem.bottomNavigationItems.elementAt(currentIndex).page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: kMainColor,
        unselectedItemColor: kTextLightColor,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          for (var bottomNavigationItem
              in TabNavigationItem.bottomNavigationItems)
            BottomNavigationBarItem(
              icon: bottomNavigationItem.icon,
              activeIcon: bottomNavigationItem.activeIcon,
              label: bottomNavigationItem.title,
            ),
        ],
      ),
    );
  }
}

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;
  final Icon activeIcon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
    @required this.activeIcon,
  });

  static List<TabNavigationItem> get bottomNavigationItems => [
        TabNavigationItem(
          page: ShopPage(),
          title: 'Acheter',
          icon: Icon(Icons.attach_money_outlined),
          activeIcon: Icon(Icons.attach_money),
        ),
        TabNavigationItem(
          page: ShoppingCartPage(),
          title: 'Panier',
          icon: Icon(Icons.shopping_basket_outlined),
          activeIcon: Icon(Icons.shopping_basket),
        ),
        TabNavigationItem(
          page: UserProfilePage(),
          title: 'Profil',
          icon: Icon(Icons.person_outlined),
          activeIcon: Icon(Icons.person),
        ),
      ];
}
