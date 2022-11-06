import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/material.dart';

class DropdownList extends StatefulWidget {
  final List<String> listItems;
  final void Function(String? classification) filterProduct;

  DropdownList({required this.listItems, required this.filterProduct});

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
    widget.filterProduct(value);

    setState(() {
      dropdownValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: Container(
        height: 1,
        color: AppColors.primary,
      ),
      iconEnabledColor: AppColors.primary,
      alignment: Alignment.center,
      value: dropdownValue,
      items: widget.listItems.map((item) {
        return DropdownMenuItem(child: Text(item), value: item);
      }).toList(),
      onChanged: _onChageValue,
    );
  }
}
