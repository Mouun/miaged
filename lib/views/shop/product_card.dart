import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kDefaultPadding / 2),
            child: Image.network(product.images[0], fit: BoxFit.fitHeight),
          )
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            product.title,
            style: GoogleFonts.montserrat(color: kTextLightColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 4, bottom: 10),
          child: Text(
            product.size,
            style: GoogleFonts.lato(color: kTextLightColor),
          )
        ),
        Row(
          children: [
            Text(
              "${product.price / 100}€",
              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 18, color: kMainColor)
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.add_shopping_cart, color: kMainColor, size: 20),
              onPressed: () {
                print('ok');
              }
            ),
          ],
        )
      ],
    );
  }
}
