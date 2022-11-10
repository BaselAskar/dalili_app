import 'package:dalili_app/src/widgets/search_section/store_card.dart';
import 'package:flutter/material.dart';

class SearchStores extends StatelessWidget {
  final List stores;

  SearchStores(this.stores);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: stores.map((store) => StoreCard(store)).toList(),
      ),
    );
  }
}
