import 'package:flutter/material.dart';

import '../global/average_starts.dart';

class AverageStars extends StatelessWidget {
  final double starsSize;
  final double averageRating;

  AverageStars({required this.starsSize, required this.averageRating});

  int get _numOffillStars {
    return averageRating.floor();
  }

  double get _starPercent {
    return averageRating - _numOffillStars;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> starsList = List.generate(5, (index) {
      if (index < _numOffillStars) {
        return Icon(Icons.star, color: Colors.yellow, size: starsSize);
      }

      if (index == _numOffillStars && _starPercent > 0) {
        return Stack(alignment: Alignment.centerRight, children: [
          Icon(Icons.star_outline, size: starsSize),
          ClipRect(
              child: Align(
                  alignment: Alignment.centerRight,
                  widthFactor: _starPercent,
                  child:
                      Icon(Icons.star, color: Colors.yellow, size: starsSize)))
        ]);
      }

      return Icon(Icons.star_outline, size: starsSize);
    });

    return Container(
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: starsList,
            ),
          ),
          SizedBox(height: 5),
          Center(
            child: Text(
              '$averageRating',
              style: const TextStyle(
                  color: Color.fromRGBO(196, 176, 3, 1),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
