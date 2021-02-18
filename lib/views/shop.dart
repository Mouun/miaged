import 'package:flutter/material.dart';
import 'package:miaged/widgets/authentified-appbar.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthentifiedAppBar(title: 'Produits'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Liste des produits', style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
