import 'dart:convert';

import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../widgets/global/main_bar.dart';
import '../widgets/global/header.dart';
import '../widgets/store/store_title.dart';
import '../widgets/store/dropdownList.dart';
import '../widgets/store/product_card.dart';
import '../widgets/global/pagination.dart';

import '../utils/dimentions_utils.dart';

class StoreScreen extends StatefulWidget {
  static const path = '/store';

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  HttpRequest getStore = HttpRequest(url: '/api/public/get-store');
  HttpRequest getStoreProducts =
      HttpRequest(url: '/api/public/get-store-products');

  Future _getData({
    required String id,
  }) async {
    var storeData = await getStore.sendRequest(pathParams: [id]);
    var productsData = await getStoreProducts.sendRequest(
        query: {'storeId': id, 'pageNumber': '1', 'pageSize': '9'});

    return {'store': storeData, 'products': productsData};
  }

  @override
  Widget build(BuildContext context) {
    String storeId = ModalRoute.of(context)?.settings.arguments as String;

    EdgeInsets screenPadding = MediaQuery.of(context).padding;

    double sccrenHeight = MediaQuery.of(context).size.height;

    double viewInsetsBottom = MediaQuery.of(context).viewInsets.bottom;

    double bodyHeight = sccrenHeight -
        screenPadding.top -
        screenPadding.bottom -
        viewInsetsBottom -
        120;

    return Scaffold(
      body: Column(children: [
        MainBar(),
        Header(
          headerText: 'المتجر',
        ),
        Container(
          height: bodyHeight,
          child: FutureBuilder(
            future: _getData(id: storeId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var store = snapshot.data['store'];
                var products = snapshot.data['products'];

                var classificationsList = [
                  'الكل',
                  ...(store['classifications'] as List)
                      .map((cl) => '${cl['title']}-${cl['name']}')
                      .toList()
                ];

                Map pagination = jsonDecode(
                    getStoreProducts.response?.headers['pagination'] as String);

                int totalPages = pagination['totalPages'];

                return ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    Center(
                      child: buildStoreTitle(
                        context: context,
                        photoUrl: store['storePhotoUrl'],
                        storeName: store['name'],
                        description: store['description'],
                        city: store['city'],
                        region: store['region'],
                        address: store['address'],
                      ),
                    ),
                    if (classificationsList.length > 2)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: DropdownList(listItems: classificationsList),
                        ),
                      ),
                    if (!(products as List).isEmpty)
                      Pagination(
                          initialList: products,
                          pageSize: 9,
                          numberOfPages: totalPages,
                          getItmesRequest: (context, pageNumber, pageSize) =>
                              getStoreProducts.sendRequest(query: {
                                'storeId': storeId,
                                'pageNumber': pageNumber,
                                'pageSize': pageSize
                              }),
                          itemsBuilder: ((context, listData, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              child: ProductCard(listData[index]),
                            );
                          })),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                );
              }

              return Center(
                child: SpinKitFadingFour(
                  color: AppColors.primary,
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
