import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../utils/http_request.dart';

class WideSlides extends StatefulWidget {
  @override
  State<WideSlides> createState() => _WideSlidesState();
}

class _WideSlidesState extends State<WideSlides> {
  bool _isInitialed = false;
  List _wideSlides = [];

  HttpRequest getWideSlides = HttpRequest(url: '/api/public/wideSlides');

  void _setWideSlides() async {
    var data = await getWideSlides.sendRequest();
    print(data);
    setState(() {
      _wideSlides = data;
      _isInitialed = true;
    });
  }

  @override
  void didChangeDependencies() {
    if (!_isInitialed) {
      _setWideSlides();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _wideSlides.map((wideSlide) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: (wideSlide['photos'] as List).length > 1
              ? CarouselSlider(
                  options: CarouselOptions(
                    height: 150,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(
                      seconds: wideSlide['speed'],
                    ),
                    viewportFraction: 1.0,
                  ),
                  items: (wideSlide['photos'] as List).map((photo) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        photo['url'],
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                )
              : Container(
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(wideSlide['photos'][0]['url'],
                        fit: BoxFit.cover),
                  ),
                ),
        );
      }).toList(),
    );
  }
}
