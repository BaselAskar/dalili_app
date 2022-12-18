import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class Header extends StatelessWidget {
  final String headerText;

  const Header({this.headerText = ''});

  @override
  Widget build(BuildContext context) {
    void _goBack() {
      Navigator.of(context).pop();
    }

    Size screenSize = MediaQuery.of(context).size;

    return Container(
      color: AppColors.primary75,
      height: Dimentions.headerHeight,
      child: Row(
        children: [
          Container(
            width: screenSize.width / 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: _goBack,
                icon: Icon(
                  Icons.chevron_left,
                  size: 40,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          if (headerText != '')
            Container(
              width: screenSize.width / 3,
              child: Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      headerText,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                      ),
                    ),
                  )),
            ),
        ],
      ),
    );
  }
}
