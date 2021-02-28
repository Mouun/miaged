import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/views/offer_details.dart';

import '../constants.dart';

class CartItemCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  CartItemCard({this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Material(
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(right: kDefaultPadding),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProductDetailsPage(
                          product: product,
                          fromCart: true,
                        );
                      },
                    ),
                  );
                },
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Hero(
                      tag: product.images[0],
                      child: Image.network(
                        product.images[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: GoogleFonts.montserrat(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 10),
                    child: Text(
                      product.size,
                      style: GoogleFonts.lato(color: kTextLightColor),
                    ),
                  ),
                  Text(
                    "${product.price / 100}€",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kMainColor,
                    ),
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.clear,
                color: kMainColor,
              ),
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
