import 'package:flutter/material.dart';
import 'package:miaged/models/tab_navigation_item.dart';
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
      body: IndexedStack(
        index: currentIndex,
        children: [for (var bottomNavigationItem in TabNavigationItem.bottomNavigationItems) bottomNavigationItem.page],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: kMainColor,
        unselectedItemColor: kTextLightColor,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          for (var bottomNavigationItem in TabNavigationItem.bottomNavigationItems)
            BottomNavigationBarItem(
              icon: bottomNavigationItem.activeIcon,
              activeIcon: bottomNavigationItem.icon,
              label: bottomNavigationItem.title,
            )
        ],
      ),
    );
  }
}
