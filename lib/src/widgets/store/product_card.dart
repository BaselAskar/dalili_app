import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/material.dart';

import '../global/average_starts.dart';
import '../../screens/product_screen.dart';

class ProductCard extends StatelessWidget {
  final Map _product;

  ProductCard(this._product);

  String get _description {
    String productDes = _product['description'];

    if (productDes.length > 35) {
      return productDes.substring(0, 35) + ' ....';
    }

    return productDes;
  }

  @override
  Widget build(BuildContext context) {
    void _goToProduct(String productId) {
      Navigator.of(context).pushNamed(ProductScreen.path, arguments: productId);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: 350,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(66, 117, 117, 117),
              blurRadius: 8,
            )
          ]),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
                onTap: () => _goToProduct(_product['id']),
                child: Image.network(_product['photoUrl'], fit: BoxFit.fill)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _product['name'],
            style: const TextStyle(
                color: AppColors.storeTitle,
                fontWeight: FontWeight.w500,
                fontSize: 17),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              _description,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AverageStars(
              averageRating: _product['averageRating'] is int
                  ? (_product['averageRating'] as int).toDouble()
                  : _product['averageRating'],
              starsSize: 25),
          Container(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(
                    Icons.copy,
                    size: 20,
                  ),
                ),
                Text(_product['id']),
                Text(
                  'الرمز',
                  style: const TextStyle(
                    color: AppColors.storeTitle,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: 170,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _product['isExisted']
                    ? Text(
                        'نعم',
                        style: TextStyle(color: Colors.green),
                      )
                    : Text(
                        'لا',
                        style: TextStyle(color: Colors.red),
                      ),
                Text(
                  'متوفر في المتجر',
                  style: const TextStyle(
                    color: AppColors.storeTitle,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
