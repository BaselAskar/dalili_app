import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  final String _description;

  ProductDescription(this._description);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        _description,
        textAlign: TextAlign.end,
      ),
    );
  }
}
