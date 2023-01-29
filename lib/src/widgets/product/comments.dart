import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:dalili_app/src/widgets/global/custome_futuer_builder.dart';
import 'package:dalili_app/src/widgets/product/comment_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/dimentions_utils.dart' as dim;

class Comments extends StatefulWidget {
  final String productId;
  Comments({required this.productId});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  //States

  //Http Requests
  HttpRequest getComments = HttpRequest(url: '/api/Public/get-comments');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dim.maxWidthFormPreInPixel(context, 0.95, 500),
      child: CustomeFutureBuilder(
        future: getComments.sendRequest(query: {
          'productId': widget.productId,
          'pageNumber': '0',
          'pageSize': '10'
        }),
        errorBuilder: (error) {
          return Text(
            'فشل في طلب التعليقات',
            style: TextStyle(color: Colors.red),
          );
        },
        loadingBuilder:
            SpinKitDancingSquare(color: AppColors.primary, size: 30),
        successBuilder: (data) {
          return Column(
            children: [
              if ((data as List).length > 0)
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'التعليقات',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...(data).map((comment) => CommentRow(comment)).toList(),
                    ],
                  ),
                ),
              if ((data as List).length == 0)
                Center(child: Text('لا يوجد تعليقات')),
            ],
          );
        },
      ),
    );
  }
}
