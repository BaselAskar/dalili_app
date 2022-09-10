import 'package:flutter/material.dart';

import '../../utils/http_request.dart';

class ProductsSlides extends StatefulWidget {
  @override
  State<ProductsSlides> createState() => _ProductsSlidesState();
}

class _ProductsSlidesState extends State<ProductsSlides> {
  List _productsSlides = [];

  HttpRequest getProductsSlides =
      HttpRequest(url: '/api/public/productsSlides');

  void _setProductsSlides() async {
    var data = await getProductsSlides.sendRequest();
    setState(() {
      _productsSlides = data;
    });
  }

  @override
  void initState() {
    _setProductsSlides();

    super.initState();
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
                  Container(
                    height: 150,
                    child: Image.network(
                      product['photoUrl'],
                      fit: BoxFit.fill,
                    ),
                  ),
                  Row(
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
                      Flexible(
                        child: Text(
                          product['name'],
                        ),
                      )
                    ],
                  ),
                ]),
              );
            }).toList(),
          ),
        );
      }).toList()),
    );
  }
}
