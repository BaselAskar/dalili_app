import 'package:flutter/material.dart';

class CitiesFilter extends StatefulWidget {
  final List cities;

  CitiesFilter(this.cities);

  @override
  State<CitiesFilter> createState() => _CitiesFilterState();
}

class _CitiesFilterState extends State<CitiesFilter> {
  static const String _allValue = 'الكل';

  String selectedValue = _allValue;

  @override
  void initState() {
    // TODO: implement initState
    selectedValue = 'الكل';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton(
            value: selectedValue,
            items: [
              DropdownMenuItem(
                child: Text('الكل'),
                value: _allValue,
              ),
              ...(widget.cities
                  .map(
                    (city) => DropdownMenuItem(
                      key: ValueKey(city['id']),
                      child: Text(city['name'] as String),
                      value: city['name'],
                    ),
                  )
                  .toList())
            ],
            onChanged: (value) {},
          ),
          SizedBox(
            width: 10,
          ),
          Text('المدينة')
        ],
      ),
    );
  }
}
