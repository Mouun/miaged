import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/models/cart.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/services/carts.service.dart';
import 'package:miaged/widgets/authentified_appbar.dart';
import 'package:miaged/widgets/cart/cart_item_card.dart';
import 'package:miaged/widgets/loading_indicator.dart';

import '../constants.dart';
import '../locators.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  Future<Cart> cart;
  CartsService _cartsService = locator<CartsService>();

  Future<void> fetchCart() async {
    setState(() {
      cart = _cartsService.getCart();
    });
  }

  double getCartTotal(List<Product> products) {
    double total = 0;
    for (Product product in products) {
      total += product.price / 100;
    }
    return total;
  }

  @override
  void initState() {
    cart = _cartsService.getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthentifiedAppBar(title: 'Panier'),
      body: FutureBuilder<Cart>(
        future: cart,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 54),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          color: kMainColor,
                          onRefresh: fetchCart,
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kDefaultPadding - 8,
                            ),
                            itemCount: snapshot.data.products.length,
                            itemBuilder: (context, index) {
                              return CartItemCard(
                                product: snapshot.data.products[index],
                                onTap: () async {
                                  await _cartsService.removeProductFromCart(
                                    snapshot.data.products[index].firebaseRef,
                                  );
                                  fetchCart();
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: kDefaultPadding,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding - 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.montserrat(
                              color: kTextLightColor,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Spacer(),
                          Text(
                            '${getCartTotal(snapshot.data.products).toString()}€',
                            style: GoogleFonts.montserrat(
                              color: kTextDefaultColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottom: 0,
                  left: 0,
                  right: 0,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
