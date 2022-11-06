import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/dimentions_utils.dart';

class StoreTitle extends StatelessWidget {
  final String photoUrl;
  final String storeName;
  final String description;
  final String city;
  final String region;
  final String address;

  StoreTitle({
    required this.photoUrl,
    required this.storeName,
    required this.description,
    required this.city,
    required this.region,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColors.primary75,
            ),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 10,
              color: AppColors.primary75,
            ),
          ]),
      width: double.infinity,
      child: Column(
        children: [
          Center(
            child: Container(
              width: widthPercent(context, 0.9),
              height: 150,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: Offset.zero,
                  blurRadius: 10,
                  spreadRadius: 5,
                  color: Color.fromARGB(95, 124, 124, 124),
                )
              ]),
              child: Image.network(
                photoUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              storeName,
              style: const TextStyle(
                color: AppColors.storeTitle,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(description),
          Text(
            '$city - $region',
            style: const TextStyle(
              color: AppColors.storeTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            address,
            softWrap: true,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
