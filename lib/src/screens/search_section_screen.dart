import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:dalili_app/src/widgets/global/header.dart';
import 'package:dalili_app/src/widgets/global/main_bar.dart';
import 'package:dalili_app/src/widgets/search_section/cities_filter.dart';
import 'package:dalili_app/src/widgets/search_section/search_section_body.dart';
import 'package:dalili_app/src/widgets/search_section/store_card.dart';
import 'package:flutter/material.dart';

import '../utils/dimentions_utils.dart' as dim;
import '../widgets/global/custome_futuer_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchSectionScreen extends StatelessWidget {
  static const String path = '/search-section-screen';

  HttpRequest getCities = HttpRequest(url: '/api/public/get-cities');

  @override
  Widget build(BuildContext context) {
    Map<String, String> arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      body: Column(
        children: [
          MainBar(),
          Header(headerText: 'بحث في قسم'),
          Container(
            height: dim.bodyHeight(context,
                headerHeight: Dimentions.mainAndHeaderHeight),
            child: CustomeFutureBuilder(
                future: getCities.sendRequest(),
                loadingBuilder: Center(
                  heightFactor: 11,
                  child: SpinKitFadingFour(
                    size: 50,
                    color: AppColors.primary,
                  ),
                ),
                errorBuilder: (error) {
                  return Center(
                    child: Text('خطأ في الاتصال'),
                  );
                },
                successBuilder: ((data) => SearchSectionBody(
                    data, arg['title'] as String, arg['section'] as String))),
          )
        ],
      ),
    );
  }
}
