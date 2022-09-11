import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../utils/http_request.dart';

class ProductsSlides extends StatefulWidget {
  @override
  State<ProductsSlides> createState() => _ProductsSlidesState();
}

class _ProductsSlidesState extends State<ProductsSlides> {
  bool _isIntialed = false;

  List _productsSlides = [];

  HttpRequest getProductsSlides =
      HttpRequest(url: '/api/public/productsSlides');

  @override
  void didChangeDependencies() {
    if (!_isIntialed) {
      getProductsSlides.sendRequest().then((data) {
        setState(() {
          _productsSlides = data;
          _isIntialed = true;
        });
      }).catchError((err) => print(err['message']));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
          children: _productsSlides.map((productSlide) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: (productSlide['products'] as List).map((product) {
              return Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 2,
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
                              color: Color.fromARGB(255, 190, 53, 3),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Flexible(
                            child: Text(
                              (product['name'] as String).length > 12
                                  ? (product['name'] as String).substring(0, 12)
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
              );
            }).toList(),
          ),
        );
      }).toList()),
    );
  }
}
