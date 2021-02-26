import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/services/carts.service.dart';
import 'package:miaged/widgets/shop/product_card_skeleton.dart';

import '../../locators.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback handleOnTap;

  ProductCard({this.product, this.handleOnTap});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Future<bool> isProductInCart;

  CartsService _cartService = locator<CartsService>();

  void resetIsProductInCart() {
    setState(() {
      isProductInCart = _cartService.isInAppUserCart(widget.product.firebaseRef);
    });
  }

  @override
  void initState() {
    isProductInCart = _cartService.isInAppUserCart(widget.product.firebaseRef);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isProductInCart,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: widget.handleOnTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                    child: Hero(
                      tag: widget.product.images[0],
                      child:
                          Image.network(widget.product.images[0], fit: BoxFit.fitHeight),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    widget.product.title,
                    style: GoogleFonts.montserrat(color: kTextLightColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4, bottom: 10),
                  child: Text(
                    widget.product.size,
                    style: GoogleFonts.lato(color: kTextLightColor),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${widget.product.price / 100}€",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: kMainColor,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        snapshot.data
                            ? Icons.remove_shopping_cart
                            : Icons.add_shopping_cart,
                        color: kMainColor,
                        size: 20,
                      ),
                      onPressed: snapshot.data
                          ? () async {
                        await _cartService.removeProductFromCart(
                          widget.product.firebaseRef,
                        );
                        resetIsProductInCart();
                      }
                          : () async {
                        await _cartService.addProductToCart(
                          widget.product.firebaseRef,
                        );
                        resetIsProductInCart();
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return ProductCardSkeleton();
      },
    );
  }
}
