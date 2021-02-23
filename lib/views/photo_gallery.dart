import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagesGallery extends StatefulWidget {

  final int initialIndex;
  final List<String> images;

  ImagesGallery({
    @required this.images,
    this.initialIndex,
  });

  @override
  _ImagesGalleryState createState() => _ImagesGalleryState();
}

class _ImagesGalleryState extends State<ImagesGallery> {
  int currentIndex;

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(widget.images[index]),
              heroAttributes: PhotoViewHeroAttributes(
                tag: widget.images[index],
              ),
            );
          },
          itemCount: widget.images.length,
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
          pageController: PageController(initialPage: widget.initialIndex),
          onPageChanged: _onPageChanged,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
