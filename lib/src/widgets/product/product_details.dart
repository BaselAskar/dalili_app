import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/widgets/global/average_starts.dart';
import 'package:flutter/material.dart';

import '../../utils/dimentions_utils.dart';

class ProductDetails extends StatelessWidget {
  final Map<String, dynamic> _product;

  ProductDetails(this._product);

  @override
  Widget build(BuildContext context) {
    print(_product);

    return Center(
      child: Container(
        width: maxWidthFormPreInPixel(context, 0.95, 500),
        child: Card(
          elevation: 4,
          color: AppColors.primary75,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(_product['currency']),
                      Text(
                        _product['price'].toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'السعر',
                        style: const TextStyle(
                            color: AppColors.storeTitle,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        _product['isExisted'] ? 'نعم' : 'لا',
                        style: TextStyle(
                          color:
                              _product['isExisted'] ? Colors.green : Colors.red,
                          fontSize: 18,
                        ),
                      ),
                      const Text(
                        'متوفر في المتجر',
                        style: TextStyle(
                          color: AppColors.storeTitle,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: AverageStars(
                    starsSize: 20,
                    averageRating: (_product['averageRating'] is int)
                        ? (_product['averageRating'] as int).toDouble()
                        : _product['averageRating'],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_product['store']['phoneNumber1'].toString()),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      _product['store']['phoneNumber2'] != null
                          ? ': هاتف 1'
                          : ': هاتف',
                      style: TextStyle(
                        color: AppColors.storeTitle,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                if (_product['store']['phoneNumber2'] != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_product['store']['phoneNumber2'].toString()),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        ': هاتف 2',
                        style: TextStyle(
                            color: AppColors.storeTitle,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_product['store']['whatsapp1'].toString()),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      _product['store']['whatsapp2'] != null
                          ? ': واتساب 1'
                          : ': واتساب',
                      style: TextStyle(
                          color: AppColors.storeTitle,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                if (_product['store']['whatsapp2'] != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_product['store']['whatsapp2'].toString()),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        ': واتساب 2',
                        style: TextStyle(
                            color: AppColors.storeTitle,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
