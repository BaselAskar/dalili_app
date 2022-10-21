import 'package:flutter/material.dart';

class StoreDescription extends StatefulWidget {
  final String description;

  StoreDescription(this.description);

  @override
  State<StoreDescription> createState() => _StoreDescriptionState();
}

class _StoreDescriptionState extends State<StoreDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String formatedDescription() {
      if (isExpanded) {
        return widget.description;
      }

      if (widget.description.length > 35) {
        return widget.description.substring(0, 35) + '...';
      }

      return widget.description;
    }

    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          child: Text(
            formatedDescription(),
            softWrap: true,
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(isExpanded ? 'عرض أقل' : 'عرض أكثر'),
        )
      ],
    );
  }
}
