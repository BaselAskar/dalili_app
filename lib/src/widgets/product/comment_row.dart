import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/widgets/global/average_start.dart';
import 'package:flutter/material.dart';

class CommentRow extends StatelessWidget {
  final Map<String, dynamic> _comment;

  CommentRow(this._comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: AppColors.primary75))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(_comment['userName']),
              SizedBox(width: 10),
              CircleAvatar(
                backgroundImage: NetworkImage(_comment['userPhotoUrl']),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AverageStars(
                starsSize: 20,
                averageRating: (_comment['rating'] as int).toDouble(),
                hideValue: true,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text(_comment['content'])],
          ),
        ],
      ),
    );
  }
}
