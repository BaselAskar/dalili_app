import '../../screens/product_screen.dart';
import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../utils/http_request.dart';

class ProductsSlides extends StatelessWidget {
  final List productsSlidesData;

  ProductsSlides(this.productsSlidesData);

  @override
  Widget build(BuildContext context) {
    void goToProduct(String productId) {
      Navigator.of(context).pushNamed(ProductScreen.path, arguments: productId);
    }

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.grey, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              color: Colors.black26,
              blurRadius: 10,
            )
          ]),
      child: Column(
          children: productsSlidesData.map((productSlide) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: (productSlide['products'] as List).map((product) {
              return GestureDetector(
                onTap: () => goToProduct(product['id']),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width / 2 - 25,
                  child: Column(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 150,
                        child: Image.network(
                          product['photoUrl'],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              '${(product['currency'] as String).substring(0, (product['currency'] as String).indexOf(' '))} ${product['price']}',
                              style: const TextStyle(
                                color: Color.fromRGBO(190, 53, 3, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Flexible(
                              child: Text(
                                (product['name'] as String).length > 12
                                    ? (product['name'] as String)
                                        .substring(0, 12)
                                    : product['name'],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        product['store']['name'],
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ]),
                ),
              );
            }).toList(),
          ),
        );
      }).toList()),
    );
  }
}
