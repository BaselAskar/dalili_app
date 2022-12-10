import 'package:dalili_app/src/widgets/product/like_Button.dart';
import 'package:dalili_app/src/widgets/product/rating_product.dart';
import 'package:flutter/material.dart';

class UserProductBar extends StatelessWidget {
  final bool isLike;
  final String productId;

  UserProductBar({this.isLike = false, this.productId = ''});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
          child: Row(
        children: [
          LikeButton(isLike, productId),
          RatingProduct(),
        ],
      )),
    );
  }
}
