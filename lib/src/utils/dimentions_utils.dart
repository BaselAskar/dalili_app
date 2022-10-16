import 'package:flutter/cupertino.dart';

double widthPercent(BuildContext context, double percent) {
  double width = MediaQuery.of(context).size.width;

  return width * percent;
}

double maxWidthFormPreInPixel(
    BuildContext context, double percent, double maxWidth) {
  double screenWidth = MediaQuery.of(context).size.width;

  return (screenWidth * percent) < maxWidth ? screenWidth * percent : maxWidth;
}

double bodyHeight(BuildContext context, {double headerHeight = 0}) {
  EdgeInsets screenPadding = MediaQuery.of(context).padding;

  double sccrenHeight = MediaQuery.of(context).size.height;

  double viewInsetsBottom = MediaQuery.of(context).viewInsets.bottom;

  return sccrenHeight -
      screenPadding.top -
      screenPadding.bottom -
      viewInsetsBottom -
      headerHeight;
}
