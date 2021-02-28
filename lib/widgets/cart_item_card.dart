import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/models/product.dart';

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
              child: SizedBox(
                width: 90,
                height: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                  child: Image.network(
                    product.images[0],
                    fit: BoxFit.cover,
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
                    style: GoogleFonts.montserrat(color: kTextDefaultColor),
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
