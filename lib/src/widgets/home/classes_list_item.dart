import 'package:flutter/material.dart';

class ClassesListItem extends StatelessWidget {
  final _classification;

  bool isShowListClassifications = false;

  ClassesListItem(this._classification);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        _classification['title'],
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: (_classification['sections'] as List)
          .map((sec) => Container(
                margin: const EdgeInsets.all(8),
                child: Center(
                    child: ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(sec['name']),
                  ),
                )),
              ))
          .toList(),
    );
  }
}
