import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../utils/http_request.dart';
import '../../screens/store_screen.dart';

class WideSlides extends StatelessWidget {
  final List wideSlidesData;

  WideSlides(this.wideSlidesData);

  HttpRequest getWideSlides = HttpRequest(url: '/api/public/wideSlides');

  @override
  Widget build(BuildContext context) {
    void _goToStore(String storeId) {
      Navigator.of(context).pushNamed(StoreScreen.path, arguments: storeId);
    }

    return FutureBuilder(
      future: getWideSlides.sendRequest(),
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: (snapshot.data as List).map((wideSlide) {
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
                          return GestureDetector(
                            onTap: () => _goToStore(photo['store']['id']),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                photo['url'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : GestureDetector(
                        onTap: () =>
                            _goToStore(wideSlide['photos'][0]['store']['id']),
                        child: Container(
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(wideSlide['photos'][0]['url'],
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
              );
            }).toList(),
          );
        }
        return Container();
      },
    );
  }
}

Widget buildWideSlides(BuildContext context, List wideSlidesData) {
  void _goToStore(String storeId) {
    print(storeId);
    Navigator.of(context).pushNamed(StoreScreen.path, arguments: storeId);
  }

  return Column(
    children: wideSlidesData.map((wideSlide) {
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
                  aspectRatio: 1,
                ),
                items: (wideSlide['photos'] as List).map((photo) {
                  return GestureDetector(
                    onTap: () => _goToStore(photo['store']['id']),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        photo['url'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              )
            : GestureDetector(
                onTap: () => _goToStore(wideSlide['photos'][0]['store']['id']),
                child: Container(
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(wideSlide['photos'][0]['url'],
                        fit: BoxFit.cover),
                  ),
                ),
              ),
      );
    }).toList(),
  );
}
