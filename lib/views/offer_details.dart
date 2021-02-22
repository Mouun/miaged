import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/product.dart';
import 'package:miaged/views/photo_gallery.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              SizedBox(
                height: pageSize.height * 0.6,
                child: Swiper(
                  itemCount: widget.product.images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        open(context, index);
                      },
                      child: Hero(
                        tag: widget.product.images[index],
                        child: Image.network(
                          widget.product.images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  pagination: SwiperPagination(
                    builder: new DotSwiperPaginationBuilder(
                      activeColor: kMainColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoGallery(
          images: widget.product.images,
          initialIndex: index,
        ),
      ),
    );
  }
}
