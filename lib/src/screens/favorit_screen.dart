import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:dalili_app/src/widgets/global/body_view.dart';
import 'package:dalili_app/src/widgets/global/custome_futuer_builder.dart';
import 'package:dalili_app/src/widgets/global/header.dart';
import 'package:dalili_app/src/widgets/global/main_bar.dart';
import 'package:dalili_app/src/widgets/store/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/dimentions_utils.dart' as dim;

class FavoritScreen extends StatelessWidget {
  static const String path = '/favorites';

  HttpRequest getFavReq =
      HttpRequest(url: '/api/profile/get-like-products', auth: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainBar(),
          Header(headerText: 'المنتجات المهتم بها'),
          Container(
              height: dim.bodyHeight(context,
                  headerHeight:
                      Dimentions.headerHeight + Dimentions.mainBarHeight),
              padding: const EdgeInsets.all(20),
              child: CustomeFutureBuilder(
                future: getFavReq.sendRequest(),
                errorBuilder: (error) {
                  return Center(child: Text('خطأ في الطلب'));
                },
                loadingBuilder: Center(
                    child:
                        SpinKitFoldingCube(color: AppColors.primary, size: 40)),
                successBuilder: (data) {
                  if ((data as List).length == 0) {
                    return Center(child: Text('لا يوجد أي منتجات'));
                  }

                  return ListView(
                    padding: const EdgeInsets.all(0),
                    children: (data as List).map((product) {
                      return ProductCard(product);
                    }).toList(),
                  );
                },
              )),
        ],
      ),
    );
  }
}
