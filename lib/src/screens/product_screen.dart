import 'package:flutter/material.dart';

import '../widgets/global/main_bar.dart';
import '../widgets/global/header.dart';

class ProductScreen extends StatefulWidget {
  static const String path = "/product";

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        MainBar(),
        Header(),
      ]),
    );
  }
}
