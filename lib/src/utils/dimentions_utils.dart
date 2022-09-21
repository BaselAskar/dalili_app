import 'package:flutter/cupertino.dart';

double widthPercent(BuildContext context, double percent) {
  double width = MediaQuery.of(context).size.width;

  return width * (percent / 100);
}
