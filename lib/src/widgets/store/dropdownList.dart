import 'package:flutter/material.dart';

class DropdownList extends StatefulWidget {
  final List<String> listItems;

  DropdownList({required this.listItems});

  @override
  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  String? dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.listItems.first;
    super.initState();
  }

  void _onChageValue(String? value) {
    setState(() {
      dropdownValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      alignment: Alignment.center,
      value: dropdownValue,
      items: widget.listItems.map((item) {
        return DropdownMenuItem(child: Text(item), value: item);
      }).toList(),
      onChanged: _onChageValue,
    );
  }
}
