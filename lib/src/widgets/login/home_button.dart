import 'package:dalili_app/src/screens/home_screen.dart';
import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: IconButton(
          icon: Icon(
            Icons.home,
            color: AppColors.loginColor,
          ),
          iconSize: 40,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.path);
          },
        ),
      ),
    );
  }
}
