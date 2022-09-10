import 'package:flutter/material.dart';

import '../../utils/http_request.dart';

class WideSlides extends StatefulWidget {
  @override
  State<WideSlides> createState() => _WideSlidesState();
}

class _WideSlidesState extends State<WideSlides> {
  List _wideSlides = [];

  HttpRequest getWideSlides = HttpRequest(url: '/api/public/wideSlides');

  void _setWideSlides() async {
    var data = await getWideSlides.sendRequest();
    print(data);
    _wideSlides = data;
  }

  @override
  void initState() {
    _setWideSlides();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _wideSlides.map((wideSlide) {
        return Container();
      }).toList(),
    );
  }
}
