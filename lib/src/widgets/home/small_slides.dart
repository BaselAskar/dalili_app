import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../utils/http_request.dart';
import '../../screens/store_screen.dart';
import '../global/grid.dart';

class SmallSlides extends StatelessWidget {
  final List smallSlidesData;

  SmallSlides(this.smallSlidesData);

  @override
  Widget build(BuildContext context) {
    void _gotToStore(String storeId) {
      Navigator.of(context).pushNamed(StoreScreen.path, arguments: storeId);
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Grid(
        numOfCol: 2,
        mainAxisSpeacing: 20,
        crossAxisSpeacing: 20,
        children: smallSlidesData.map((slide) {
          return Container(
            child: Column(
              children: [
                CarouselSlider(
                  items: (slide['photos'] as List).map((photo) {
                    return Container(
                        height: 250,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            photo['url'],
                            fit: BoxFit.fill,
                          ),
                        ));
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(
                      seconds: slide['speed'],
                    ),
                    aspectRatio: 1,
                    viewportFraction: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        slide['store']['name'],
                        style: TextStyle(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => _gotToStore(slide['store']['id']),
                      child: Row(
                        children: [
                          Text("إلى المتجر"),
                          Icon(Icons.store),
                        ],
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Container(
                        width: 60,
                        child: Text(
                          '${slide['store']['city']}-${slide['store']['region']}',
                          softWrap: true,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Widget buildSmallSlides(BuildContext context, List smallSlidesData) {
//   void _gotToStore(String storeId) {
//     Navigator.of(context).pushNamed(StoreScreen.path, arguments: storeId);
//   }

//   return Container(
//     padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
//     child: Grid(
//       numOfCol: 2,
//       mainAxisSpeacing: 20,
//       crossAxisSpeacing: 20,
//       children: smallSlidesData.map((slide) {
//         return Container(
//           child: Column(
//             children: [
//               CarouselSlider(
//                 items: (slide['photos'] as List).map((photo) {
//                   return Container(
//                       height: 250,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.network(
//                           photo['url'],
//                           fit: BoxFit.fill,
//                         ),
//                       ));
//                 }).toList(),
//                 options: CarouselOptions(
//                   autoPlay: true,
//                   autoPlayAnimationDuration: Duration(
//                     seconds: slide['speed'],
//                   ),
//                   aspectRatio: 1,
//                   viewportFraction: 1,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Text(
//                       slide['store']['name'],
//                       style: TextStyle(
//                         color: AppColors.primary,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: () => _gotToStore(slide['store']['id']),
//                     child: Row(
//                       children: [
//                         Text("إلى المتجر"),
//                         Icon(Icons.store),
//                       ],
//                     ),
//                   ),
//                   FittedBox(
//                     fit: BoxFit.cover,
//                     child: Container(
//                       width: 60,
//                       child: Text(
//                         '${slide['store']['city']}-${slide['store']['region']}',
//                         softWrap: true,
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     ),
//   );
// }
