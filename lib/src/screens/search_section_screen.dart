import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:dalili_app/src/widgets/global/header.dart';
import 'package:dalili_app/src/widgets/global/main_bar.dart';
import 'package:dalili_app/src/widgets/search_section/cities_filter.dart';
import 'package:dalili_app/src/widgets/search_section/store_card.dart';
import 'package:flutter/material.dart';

import '../utils/dimentions_utils.dart' as dym;
import '../widgets/global/custome_futuer_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchSection extends StatefulWidget {
  static const String path = '/search-section-screen';

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  HttpRequest getStoresInSection =
      HttpRequest(url: '/api/public/search-section');

  HttpRequest getCities = HttpRequest(url: '/api/public/get-cities');

  Future<Map<String, Object>> getSearchSectionRequest(
      String title, String name) async {
    var storesData = await getStoresInSection.sendRequest(query: {
      'title': title,
      'name': name,
      'pageNumber': '1',
      'PageSize': '10',
    });

    var citiesData = await getCities.sendRequest();

    return {'stores': storesData, 'cities': citiesData};
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> params =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      body: Column(
        children: [
          MainBar(),
          Header(
            headerText: 'بحث عن قسم',
          ),
          Container(
            height: dym.bodyHeight(context,
                headerHeight: Dimentions.mainAndHeaderHeight),
            child: CustomeFutureBuilder(
              future: getSearchSectionRequest(
                  params['title'] as String, params['section'] as String),
              loadingBuilder: Center(
                child: SpinKitCircle(color: AppColors.primary, size: 40),
              ),
              successBuilder: (data) {
                return ListView(
                  padding: const EdgeInsets.only(top: 10),
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          '${params['title']} - ${params['section']}',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    CitiesFilter(data['cities']),
                    Container(
                      child: Column(
                          children: (data['stores'] as List).map((store) {
                        return StoreCard(store);
                      }).toList()),
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
