import 'dart:convert';

import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:dalili_app/src/widgets/global/pagination.dart';
import 'package:dalili_app/src/widgets/home/classifications.dart';
import 'package:dalili_app/src/widgets/store/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StoreProductsList extends StatefulWidget {
  final String storeId;
  final List classifications;

  StoreProductsList({required this.storeId, required this.classifications});

  List<String> get listItems {
    List<String> classificationsText = classifications.map((cl) {
      return '${cl['title']}-${cl['name']}';
    }).toList();

    return ['الكل', ...classificationsText];
  }

  @override
  State<StoreProductsList> createState() => _StoreProductsListState();
}

class _StoreProductsListState extends State<StoreProductsList> {
  //States
  List _productsList = [];
  Map<String, dynamic> _pagination = {};
  bool _isGettingProducts = false;
  String? _dropdownValue = 'الكل';

  //Http Request
  HttpRequest getStoreProducts =
      HttpRequest(url: '/api/public/get-store-products');

  HttpRequest getStoreClssifications = HttpRequest(url: '/api/public/get-');

  //Methods
  Future<void> _getProducts({required String section}) async {
    List data = [];

    setState(() {
      _isGettingProducts = true;
    });

    if (section == 'الكل') {
      data = await getStoreProducts
          .sendRequest(query: {'storeId': widget.storeId});
    } else {
      String title = section.substring(0, section.indexOf('-'));
      String name = section.substring(section.indexOf('-') + 1);

      data = await getStoreProducts.sendRequest(
          query: {'storeId': widget.storeId, 'title': title, 'name': name});
    }

    Map<String, dynamic> pagination =
        jsonDecode(getStoreProducts.response!.headers['pagination'] as String);

    setState(() {
      _productsList = data;
      _pagination = pagination;
      _isGettingProducts = false;
    });
  }

  void _onChangeValue(String? value) {
    setState(() {
      _dropdownValue = value;
    });

    _getProducts(section: value as String);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProducts(section: 'الكل');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //store classifications
        if (widget.classifications.length > 1)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: DropdownButton(
              underline: Container(
                height: 1,
                color: AppColors.primary,
              ),
              iconEnabledColor: AppColors.primary,
              alignment: Alignment.center,
              value: _dropdownValue,
              items: widget.listItems.map((item) {
                return DropdownMenuItem(child: Text(item), value: item);
              }).toList(),
              onChanged: _onChangeValue,
            ),
          ),
        if (_isGettingProducts)
          Container(
            height: 150,
            child: Center(
              child: SpinKitFadingFour(
                color: AppColors.primary,
                size: 40,
              ),
            ),
          ),
        if (!_isGettingProducts)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Pagination(
              getItmesRequest: (context, pageNumber, pageSize) =>
                  getStoreProducts.sendRequest(
                query: {
                  'storeId': widget.storeId,
                  'pageNumber': pageNumber,
                  'pageSize': pageSize,
                },
              ),
              initialList: _productsList,
              itemsBuilder: (context, listData, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ProductCard(listData[index]),
                );
              },
              numberOfPages: _pagination['totalPages'],
              pageSize: 10,
            ),
          )
      ],
    );

    //Loading
    if (_isGettingProducts) {
      return Expanded(
        child: Center(
          child: SpinKitFadingFour(
            color: AppColors.primary,
            size: 40,
          ),
        ),
      );
    }

    Map<String, dynamic> pagination =
        jsonDecode(getStoreProducts.response!.headers['pagination'] as String);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Pagination(
        getItmesRequest: (context, pageNumber, pageSize) =>
            getStoreProducts.sendRequest(
          query: {
            'storeId': widget.storeId,
            'pageNumber': pageNumber,
            'pageSize': pageSize,
          },
        ),
        initialList: _productsList,
        itemsBuilder: (context, listData, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: ProductCard(listData[index]),
          );
        },
        numberOfPages: pagination['totalPages'],
        pageSize: 10,
      ),
    );
  }
}
