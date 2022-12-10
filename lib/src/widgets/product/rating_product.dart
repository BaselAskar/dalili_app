import 'package:flutter/material.dart';

class RatingProduct extends StatefulWidget {
  @override
  State<RatingProduct> createState() => _RatingProductState();
}

class _RatingProductState extends State<RatingProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(5, (index) {
          return IconButton(onPressed: () {}, icon: Icon(Icons.star_border));
        }),
      ),
    );
  }
}
