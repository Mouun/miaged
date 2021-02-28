import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/constants.dart';
import 'package:miaged/models/category.dart';

import '../extensions/string.extension.dart';

typedef void IntCallback(int index);

class CategoriesRow extends StatefulWidget {
  final List<Category> categories;
  final IntCallback handleClickCategory;

  CategoriesRow(
      {@required this.categories, @required this.handleClickCategory});

  @override
  _CategoriesRowState createState() => _CategoriesRowState();
}

class _CategoriesRowState extends State<CategoriesRow> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategoryIndex = index;
              });
              widget.handleClickCategory(index);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.categories[index].label.capitalize(),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    color: selectedCategoryIndex == index
                        ? kMainColor
                        : kTextLightColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
