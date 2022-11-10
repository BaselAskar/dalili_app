import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../screens/search_section_screen.dart';

class ClassificationListItem extends StatefulWidget {
  final Map<String, dynamic> _classification;

  ClassificationListItem(this._classification);

  @override
  State<ClassificationListItem> createState() => _ClassificationListItemState();
}

class _ClassificationListItemState extends State<ClassificationListItem> {
  bool _showList = false;

  void _goToSeachSection(BuildContext context, String title, String section) {
    Navigator.of(context).pushNamed(SearchSectionScreen.path,
        arguments: {'title': title, 'section': section});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton(
          dropdownColor: AppColors.primary75,
          iconSize: 0,
          underline: Container(),
          alignment: Alignment.center,
          value: widget._classification['title'],
          items: [
            DropdownMenuItem(
              child: InkWell(
                enableFeedback: true,
                child: Text(
                  widget._classification['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              value: widget._classification['title'],
              enabled: false,
            ),
            ...((widget._classification['sections'] as List)
                .map((sec) => DropdownMenuItem(
                      child: Text(sec['name']),
                      value: sec['name'] as String,
                    ))
                .toList())
          ],
          onChanged: (value) {
            _goToSeachSection(
                context, widget._classification['title'], value as String);
          },
        ),
      ],
    );
  }
}
