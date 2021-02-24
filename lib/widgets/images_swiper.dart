import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:miaged/views/photo_gallery.dart';

import '../constants.dart';

class ImagesSwiper extends StatelessWidget {
  final List<String> images;

  ImagesSwiper({this.images});

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagesGallery(
          images: images,
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            open(context, index);
          },
          child: Hero(
            tag: images[index],
            child: Image.network(
              images[index],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      pagination: SwiperPagination(
        margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
        builder: new DotSwiperPaginationBuilder(
          activeColor: kMainColor,
        ),
      ),
    );
  }
}
