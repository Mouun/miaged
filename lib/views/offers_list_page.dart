import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miaged/locators.dart';
import 'package:miaged/services/auth.service.dart';
import 'package:miaged/widgets/authentified-appbar.dart';
import 'package:provider/provider.dart';

class OffersListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthentifiedAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Feed', style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
