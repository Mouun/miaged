import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants.dart';

class ProductCardSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kShimmerBaseColor,
      highlightColor: Colors.white38,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: kShimmerBaseColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Container(
              color: kShimmerBaseColor,
              height: 17,
              width: 100,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4, bottom: 10),
            child: Container(
              color: kShimmerBaseColor,
              height: 17,
              width: 75,
            ),
          ),
          Container(
            color: kShimmerBaseColor,
            height: 17,
            width: 50,
          )
        ],
      ),
    );
  }
}
