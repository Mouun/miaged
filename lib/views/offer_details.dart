import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/extensions/color.extension.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/services/carts.service.dart';
import 'package:miaged/widgets/authentified_appbar.dart';
import 'package:miaged/widgets/custom_button.dart';
import 'package:miaged/widgets/images_swiper.dart';
import 'package:miaged/widgets/loading_indicator.dart';

import '../locators.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final bool fromCart;

  ProductDetailsPage({this.product, this.fromCart = false});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Future<bool> isProductInCart;
  CartsService _cartService = locator<CartsService>();

  void resetIsProductInCart() {
    setState(() {
      isProductInCart =
          _cartService.isInAppUserCart(widget.product.firebaseRef);
    });
  }

  @override
  void initState() {
    isProductInCart = _cartService.isInAppUserCart(widget.product.firebaseRef);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AuthentifiedAppBar(
          title: widget.product.title,
        ),
        body: FutureBuilder<bool>(
          future: isProductInCart,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: pageSize.height * 0.5,
                              child:
                                  ImagesSwiper(images: widget.product.images),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                top: kDefaultPadding,
                                left: kDefaultPadding,
                                right: kDefaultPadding,
                                bottom: widget.fromCart ? kDefaultPadding : 0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product.title,
                                    style: GoogleFonts.montserrat(
                                      color: kMainColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 16,
                                      bottom: 32,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.lato(
                                          color: Colors.black87,
                                          fontSize: 16,
                                        ),
                                        text: '${widget.product.size} · ',
                                        children: [
                                          TextSpan(
                                            text:
                                                '${widget.product.condition} · ',
                                          ),
                                          TextSpan(
                                            text: widget.product.brand,
                                            style: TextStyle(
                                              color: kMainColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Couleur',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: kDefaultPadding / 2,
                                    ),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: new BoxDecoration(
                                        color: HexColor.fromHex(
                                            widget.product.color),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Description',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: kDefaultPadding / 2,
                                    ),
                                    child: ExpandText(
                                      widget.product.description
                                          .replaceAll('\\n', '\n'),
                                      maxLines: 3,
                                      style: GoogleFonts.lato(),
                                      arrowColor: kMainColor,
                                    ),
                                  ),
                                  Text(
                                    '${widget.product.price / 100}€',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  !widget.fromCart
                      ? Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(kDefaultPadding),
                            child: CustomButton(
                              text: snapshot.data
                                  ? 'Retirer du panier'
                                  : 'Ajouter au panier',
                              onPressed: snapshot.data
                                  ? () async {
                                      await _cartService.removeProductFromCart(
                                        widget.product.firebaseRef,
                                      );
                                      resetIsProductInCart();
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          'Le produit a été retiré du panier avec succés',
                                        ),
                                        duration: Duration(seconds: 2),
                                      ));
                                    }
                                  : () async {
                                      await _cartService.addProductToCart(
                                        widget.product.firebaseRef,
                                      );
                                      resetIsProductInCart();
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Le produit a été ajouté au panier avec succés',
                                          ),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                            ),
                          ),
                        )
                      : Container()
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}
