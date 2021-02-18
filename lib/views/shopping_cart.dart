import 'package:flutter/material.dart';
import 'package:miaged/widgets/authentified-appbar.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthentifiedAppBar(title: 'Panier'),
      body: Center(
        child: Text('Panier', style: TextStyle(fontSize: 30)),
      ),
    );
  }
}
