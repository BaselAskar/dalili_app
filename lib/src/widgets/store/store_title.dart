import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/dimentions_utils.dart';

Widget buildStoreTitle({
  required BuildContext context,
  required String photoUrl,
  required String storeName,
  required String description,
  required String city,
  required String region,
  required String address,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
    ),
    width: double.infinity,
    child: Column(
      children: [
        Center(
          child: Container(
            width: widthPercent(context, 90),
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
