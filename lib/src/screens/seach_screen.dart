import 'dart:convert';

import 'package:dalili_app/src/utils/http_request.dart';
import 'package:dalili_app/src/widgets/global/custome_futuer_builder.dart';
import 'package:dalili_app/src/widgets/search_section/store_card.dart';
import 'package:dalili_app/src/widgets/store/product_card.dart';
import 'package:flutter/material.dart';

import '../utils/dimentions_utils.dart' as dim;
import '../utils/constants.dart';

class SearchScreen extends StatefulWidget {
  static const String path = '/search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _init = false;
  TextEditingController searchController = TextEditingController();
  FocusNode _searchFocus = FocusNode();

  HttpRequest searchReq = HttpRequest(url: '/api/public/search');

  //States
  String _searchText = '';

  @override
  void didChangeDependencies() {
    if (!_init) {
      FocusScope.of(context).requestFocus(_searchFocus);
      _init = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double statusbar = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary75,
        foregroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Stack(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value.trim();
                });
              },
              focusNode: _searchFocus,
              textDirection: TextDirection.rtl,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20, color: AppColors.primary),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: AppColors.primary,
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
          height: dim.bodyHeight(context, headerHeight: 57),
          child: _searchText == ''
              ? Center(
                  child: Text('أدخل اسم متجر أو منتج'),
                )
              : CustomeFutureBuilder(
                  future: searchReq.sendRequest(query: {'search': _searchText}),
                  loadingBuilder: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                  successBuilder: (data) {
                    if ((data['stores'] as List).length > 0 ||
                        (data['products'] as List).length > 0) {
                      return ListView(
                        padding: const EdgeInsets.all(0),
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: (data['stores'] as List).map((store) {
                                return StoreCard(store);
                              }).toList(),
                            ),
                          ),
                          Container(
                            child: Column(
                              children:
                                  (data['products'] as List).map((product) {
                                return ProductCard(product);
                              }).toList(),
                            ),
                          )
                        ],
                      );
                    }

                    return Center(
                      child: Text('لا يوجد نتائج'),
                    );
                  })),
    );
  }
}
