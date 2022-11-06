import 'dart:convert';

import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:dalili_app/src/widgets/store/store_products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../widgets/global/main_bar.dart';
import '../widgets/global/header.dart';
import '../widgets/global/custome_futuer_builder.dart';
import '../widgets/store/store_title.dart';
import '../widgets/store/dropdownList.dart';
import '../widgets/store/product_card.dart';
import '../widgets/global/pagination.dart';

import '../utils/dimentions_utils.dart' as dim;

class StoreScreen extends StatelessWidget {
  static const String path = '/store';

  HttpRequest getStore = HttpRequest(url: '/api/public/get-store');

  Future<Map<String, dynamic>> _getStoreReq(String storeId) async {
    Map<String, dynamic> storeData =
        await getStore.sendRequest(pathParams: [storeId]);

    return storeData;
  }

  @override
  Widget build(BuildContext context) {
    String storeId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Column(
        children: [
          MainBar(),
          Header(
            headerText: 'المتجر',
          ),
          Container(
            height: dim.bodyHeight(context,
                headerHeight: Dimentions.mainAndHeaderHeight),
            child: CustomeFutureBuilder(
              future: _getStoreReq(storeId),
              loadingBuilder: Center(
                child: SpinKitFadingFour(
                  color: AppColors.primary,
                  size: 40,
                ),
              ),
              successBuilder: (data) {
                return ListView(
                  padding: const EdgeInsets.all(0),
                  children: <Widget>[
                    StoreTitle(
                      photoUrl: data['storePhotoUrl'],
                      storeName: data['name'],
                      description: data['description'],
                      city: data['city'],
                      region: data['region'],
                      address: data['address'],
                    ),
                    StoreProductsList(
                      storeId: storeId,
                      classifications: data['classifications'],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
