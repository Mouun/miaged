import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isInCart;
  final VoidCallback handleOnTap;
  final VoidCallback addToCartAction;
  final VoidCallback removeFromCartAction;

  ProductCard({
    this.product,
    this.isInCart,
    this.handleOnTap,
    this.addToCartAction,
    this.removeFromCartAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOnTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Hero(
                tag: product.images[0],
                child: Image.network(product.images[0], fit: BoxFit.fitHeight),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              product.title,
              style: GoogleFonts.montserrat(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4, bottom: 10),
            child: Text(
              product.size,
              style: GoogleFonts.lato(color: kTextLightColor),
            ),
          ),
          Row(
            children: [
              Text(
                "${product.price / 100}€",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: kMainColor,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  isInCart
                      ? Icons.remove_shopping_cart
                      : Icons.add_shopping_cart,
                  color: kMainColor,
                  size: 24,
                ),
                onPressed: isInCart ? removeFromCartAction : addToCartAction,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
