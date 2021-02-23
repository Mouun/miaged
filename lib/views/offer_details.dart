import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/extensions/color.extension.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/widgets/custom_button.dart';
import 'package:miaged/widgets/images_swiper.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  ProductDetailsPage({this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: pageSize.height * 0.5,
              child: ImagesSwiper(images: widget.product.images),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.55,
              minChildSize: 0.55,
              maxChildSize: 0.85,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        bottom: kDefaultPadding * 2,
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        top: kDefaultPadding,
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
                                  color: kTextDefaultColor,
                                  fontSize: 16,
                                ),
                                text: '${widget.product.size} · ',
                                children: [
                                  TextSpan(
                                    text: '${widget.product.condition} · ',
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
                              color: kTextDefaultColor,
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
                                color: HexColor.fromHex(widget.product.color),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Text(
                            'Description',
                            style: GoogleFonts.montserrat(
                              color: kTextDefaultColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ExpandText(
                            widget.product.description.replaceAll('\\n', '\n'),
                            maxLines: 3,
                            style: GoogleFonts.lato(
                              color: kTextDefaultColor,
                            ),
                            arrowColor: kMainColor,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: kDefaultPadding / 2),
                            child: Text(
                              '${widget.product.price / 100}€',
                              style: GoogleFonts.montserrat(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: CustomButton(
                        text: 'Ajouter au panier',
                        onPressed: () {},
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
