import 'package:dalili_app/src/providers/auth_provider.dart';
import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/shared_data.dart';
import 'package:dalili_app/src/widgets/global/screen_title.dart';
import 'package:dalili_app/src/widgets/product/user_product_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/dimentions_utils.dart';

import '../utils/http_request.dart';
import '../widgets/global/main_bar.dart';
import '../widgets/global/header.dart';
import '../widgets/product/product_images.dart';
import '../widgets/product/product_description.dart';
import '../widgets/product/product_details.dart';

class ProductScreen extends StatefulWidget {
  static const String path = "/product";

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  HttpRequest getProduct =
      HttpRequest(url: '/api/public/get-product', auth: true);
  bool _init = false;

  //States
  String _wildImageUrl = '';
  List<String> _imagesUrl = [];
  bool _isLogin = false;
  Map? _currentUser = null;

  Future _getProductReq(String productId) async {
    var data = await getProduct.sendRequest(pathParams: [productId]);
    return {'product': data};
  }

  @override
  void didChangeDependencies() {
    if (!_init) {
      // Provider.of<Auth>(context).isLogin.then((value) {
      //   setState(() {
      //     _isLogin = value;
      //   });
      // });
      ShD.getUser().then((result) {
        if (result != null) {
          setState(() {
            _isLogin = true;
            _currentUser = result;
          });
        }
      });
      _init = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Column(children: [
        MainBar(),
        Header(headerText: 'المنتج'),
        Container(
          height: bodyHeight(context, headerHeight: 120),
          child: FutureBuilder(
            future: _getProductReq(productId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var product = snapshot.data['product'];

                bool isLikedProduct = product['usersLikes'] != null &&
                        _currentUser != null
                    ? (product['usersLikes'] as List).any(
                        (user) => user['userName'] == _currentUser!['userName'])
                    : false;

                String mainPhotoUrl = (product['photos'] as List)
                    .firstWhere((photo) => photo['isMain'])['url'];

                List photos = (product['photos'] as List);

                photos.sort((ph1, ph2) =>
                    ph1['isMain'].hashCode.compareTo(ph2['isMain'].hashCode));

                print(photos);

                return ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    ScreenTitle(product['name']),
                    ProductImages(
                        wildImageUrl: mainPhotoUrl,
                        imagesUrl: photos
                            .map((photo) => photo['url'] as String)
                            .toList()),
                    ProductDescription(product['description']),
                    if (_isLogin)
                      UserProductBar(
                        isLike: isLikedProduct,
                        productId: productId,
                        userRating: product['userRating'],
                      ),
                    ProductDetails(product),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
              }

              return Center(
                child: SpinKitFadingGrid(
                  color: AppColors.primary,
                  size: 70,
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
