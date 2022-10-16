import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget {
  static const String path = '/photo_view';

  @override
  Widget build(BuildContext context) {
    String _imgUrl = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(_imgUrl),
      ),
    );
  }
}
