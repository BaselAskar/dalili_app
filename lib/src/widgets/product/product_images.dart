import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../screens/photo_view_screen.dart';

import '../../utils/dimentions_utils.dart';

class ProductImages extends StatefulWidget {
  final String wildImageUrl;
  final List<String> imagesUrl;

  const ProductImages({
    required this.wildImageUrl,
    required this.imagesUrl,
  });

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  String _wildImageUrl = '';
  List<String> _imagesUrl = [];

  @override
  void initState() {
    super.initState();
    _wildImageUrl = widget.wildImageUrl;
    _imagesUrl = widget.imagesUrl;
  }

  void _viewImage(String imgUrl) {
    setState(() {
      _wildImageUrl = imgUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    void goToPhotoView(String photoUrl) {
      Navigator.of(context)
          .pushNamed(PhotoViewScreen.path, arguments: photoUrl);
    }

    return Column(
      children: [
        Container(
          width: maxWidthFormPreInPixel(context, 0.9, 470),
          height: 350,
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onTap: () => goToPhotoView(_wildImageUrl),
              child: Hero(
                tag: _wildImageUrl,
                child: Image.network(
                  _wildImageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: maxWidthFormPreInPixel(context, 0.9, 470),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _imagesUrl.map((photo) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: constraints.maxWidth * 0.17,
                  decoration: photo == _wildImageUrl
                      ? BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(10),
                        )
                      : BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GestureDetector(
                      onTap: () => _viewImage(photo),
                      child: Image.network(
                        photo,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
