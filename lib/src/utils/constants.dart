import 'package:flutter/material.dart';

const BASE_API_HTTPS = 'https://dalilisy.herokuapp.com';

const APPLICATION_JSON = 'application/json';

class Dimentions {
  static const double mainBarHeight = 70;
  static const double headerHeight = 50;
  static const double logoHeight = 40;
  static const double mainAndHeaderHeight = mainBarHeight + headerHeight;
}

class AppColors {
  static const primary = Color.fromARGB(255, 26, 143, 221);
  static const primary75 = Color.fromRGBO(218, 240, 254, 1);
  static const storeTitle = Color.fromRGBO(220, 53, 96, 1);
}

const List DUMMY_DATA = [
  {'title': 'clothets'},
  {'title': 'food'},
  {'title': 'stores'},
  {'title': 'clinics'},
  {'title': 'banks'},
  {'title': 'cars'},
  {'title': 'resturangs'},
];
