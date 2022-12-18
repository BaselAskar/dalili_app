import 'package:dalili_app/src/utils/http_request.dart';
import 'package:flutter/material.dart';

class RatingProduct extends StatefulWidget {
  final int userRating;
  final String productId;

  RatingProduct({this.userRating = 0, required this.productId});

  @override
  State<RatingProduct> createState() => _RatingProductState();
}

class _RatingProductState extends State<RatingProduct> {
  //states
  int _rating = 0;

  //Http Requests
  HttpRequest ratingReq = HttpRequest(
    url: '/api/ratings',
    method: Methods.post,
    behavior: Behavior.one,
    auth: true,
  );

  @override
  void initState() {
    _rating = widget.userRating;
    super.initState();
  }

  Future<void> _addRating(int value) async {
    try {
      await ratingReq.sendRequest(query: {
        'productId': widget.productId,
        'ratingValue': value.toString()
      });
      setState(() {
        _rating == value ? _rating = 0 : _rating = value;
      });
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(5, (index) {
          if (index + 1 > _rating) {
            return IconButton(
                onPressed: () => _addRating(index + 1),
                icon: Icon(Icons.star_border));
          }

          return IconButton(
              onPressed: () => _addRating(index + 1),
              icon: Icon(
                Icons.star,
                color: Colors.yellow,
              ));
        }),
      ),
    );
  }
}
