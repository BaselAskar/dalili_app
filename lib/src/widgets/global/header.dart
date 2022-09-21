import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/material.dart';

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
      height: 50,
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
                  child: Text(
                    headerText,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 20,
                    ),
                  )),
            ),
        ],
      ),
    );
  }
}

Widget buildHeader(BuildContext context, {String? headerText = null}) {
  void _goBack() {
    Navigator.of(context).pop();
  }

  Size screenSize = MediaQuery.of(context).size;

  return Container(
    color: AppColors.primary75,
    height: 50,
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
        if (headerText != null)
          Container(
            width: screenSize.width / 3,
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  headerText,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 20,
                  ),
                )),
          ),
      ],
    ),
  );
}
