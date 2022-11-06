import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../widgets/global/main_bar.dart';
import '../widgets/home/classifications.dart';
import '../widgets/home/products_slides.dart';
import '../widgets/home/small_slides.dart';
import '../widgets/home/wide_slides.dart';

class HomeScreen extends StatelessWidget {
  static const String path = '/';

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HttpRequest getClassifications =
      HttpRequest(url: '/api/public/classifications');

  HttpRequest getProductsSlides =
      HttpRequest(url: '/api/public/productsSlides');

  HttpRequest getWideSlides = HttpRequest(url: '/api/public/wideSlides');

  HttpRequest getSmallSlides = HttpRequest(url: '/api/public/slides');

  Future _getData() async {
    var classificationsData = await getClassifications.sendRequest();
    var productsSlidesData = await getProductsSlides.sendRequest();
    var wideSlidesData = await getWideSlides.sendRequest();
    var smallSlidesData = await getSmallSlides.sendRequest();

    return {
      'classifications': classificationsData,
      'productsSlides': productsSlidesData,
      'wideSlides': wideSlidesData,
      'smallSlides': smallSlidesData
    };
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double statusbarPadding = MediaQuery.of(context).padding.top;
    double paddingBottom = MediaQuery.of(context).padding.bottom;

    double bodyHeight = screenHeight - statusbarPadding - paddingBottom - 70;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
          child: Column(
        children: const [
          Expanded(
            child: Center(
              child: Text('List'),
            ),
          )
        ],
      )),
      body: Column(
        children: [
          MainBar(
            scaffoldKey: _scaffoldKey,
          ),
          Container(
            height: bodyHeight,
            child: FutureBuilder(
              future: _getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child: SpinKitDualRing(color: AppColors.primary),
                    ),
                  );
                }

                if (snapshot.hasData) {
                  return ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      Classifications(),
                      ProductsSlides(snapshot.data['productsSlides']),
                      WideSlides(snapshot.data['wideSlides']),
                      SmallSlides(snapshot.data['smallSlides'])
                    ],
                  );
                }

                return AlertDialog(
                  title: Text('Error'),
                  content: Text('error message' as String),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Ok'),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
