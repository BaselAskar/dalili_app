import 'dart:convert';

import 'package:dalili_app/src/providers/http_provider.dart';
import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:dalili_app/src/widgets/global/pagination.dart';
import 'package:dalili_app/src/widgets/global/screen_title.dart';
import 'package:dalili_app/src/widgets/search_section/search_stores.dart';
import 'package:dalili_app/src/widgets/search_section/store_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../utils/dimentions_utils.dart' as dim;

class SearchSectionBody extends StatefulWidget {
  final String title;
  final String section;
  final List cities;

  SearchSectionBody(this.cities, this.title, this.section);

  @override
  State<SearchSectionBody> createState() => _SearchSectionBodyState();
}

class _SearchSectionBodyState extends State<SearchSectionBody> {
  HttpRequest getStoresBySection =
      HttpRequest(url: '/api/public/search-section');

  //States
  String _selectedValue = 'الكل';
  List _sectionStores = [];
  int _totalPages = 0;
  bool _isLoading = false;

  //Methods
  Future<void> _getStoresInSection(String? value) async {
    setState(() {
      _isLoading = true;
    });

    Map<String, String> queryParams = {
      'title': widget.title,
      'name': widget.section
    };

    if (value != 'الكل') {
      queryParams.addAll({'city': value as String});
    }

    var data = await getStoresBySection.sendRequest(query: queryParams);

    Map<String, dynamic> pagination = jsonDecode(
        getStoresBySection.response!.headers['pagination'] as String);

    setState(() {
      _sectionStores = data;
      _totalPages = pagination['totalPages'] as int;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getStoresInSection(_selectedValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          dim.bodyHeight(context, headerHeight: Dimentions.mainAndHeaderHeight),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          //Title
          ScreenTitle('${widget.title} - ${widget.section}'),
          // filter select input
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: _selectedValue,
                  items: [
                    DropdownMenuItem(
                      child: Text('الكل'),
                      value: 'الكل',
                    ),
                    ...(widget.cities
                        .map(
                          (city) => DropdownMenuItem<String>(
                            key: ValueKey(city['id'] as String),
                            child: Text(city['name'] as String),
                            value: city['name'],
                          ),
                        )
                        .toList())
                  ],
                  onChanged: (String? value) {
                    _getStoresInSection(value);
                    setState(() {
                      _selectedValue = value as String;
                    });
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Text('المدينة')
              ],
            ),
          ),
          // Search result
          if (_isLoading)
            Center(
              heightFactor: 10,
              child: SpinKitFadingFour(
                color: AppColors.primary,
                size: 50,
              ),
            ),

          if (!_isLoading)
            Pagination(
                pageSize: 10,
                numberOfPages: _totalPages,
                itemsBuilder: ((context, listData, index) =>
                    StoreCard(listData[index])),
                getItmesRequest: (context, pageNumber, pageSize) =>
                    _getStoresInSection(_selectedValue),
                initialList: _sectionStores)
        ],
      ),
    );
  }
}
