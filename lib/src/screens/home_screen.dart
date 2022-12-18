import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/utils/http_request.dart';
import 'package:dalili_app/src/utils/shared_data.dart';
import 'package:dalili_app/src/widgets/home/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/dimentions_utils.dart' as dim;

import '../widgets/global/main_bar.dart';
import '../widgets/home/classifications.dart';
import '../widgets/home/products_slides.dart';
import '../widgets/home/small_slides.dart';
import '../widgets/home/wide_slides.dart';

class HomeScreen extends StatefulWidget {
  static const String path = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _init = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLogin = false;
  String? _userPhotoUrl;

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

  Future<void> _logout(BuildContext context) async {
    await Provider.of<Auth>(context, listen: false).logout();
    _scaffoldKey.currentState?.closeEndDrawer();
    setState(() {
      _isLogin = false;
    });
  }

  Future<void> _isLoginRequest(BuildContext context) async {
    bool result = await Provider.of<Auth>(context).isLogin;

    setState(() {
      _isLogin = result;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_init) {
      _isLoginRequest(context);
      ShD.getUser().then((user) {
        if (user != null) {
          setState(() {
            _userPhotoUrl = user['photoUrl'];
          });
        }
      });
      _init = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double statusbar = MediaQuery.of(context).padding.top;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _isLogin ? MainDrawer(_userPhotoUrl, _logout) : null,
      body: Column(
        children: [
          MainBar(
            showUser: true,
          ),
          Container(
            height:
                dim.bodyHeight(context, headerHeight: Dimentions.mainBarHeight),
            child: FutureBuilder(
              future: _getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary),
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

                return Center(
                  child: const Text(
                    'error...!',
                    style: TextStyle(color: Colors.brown),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
