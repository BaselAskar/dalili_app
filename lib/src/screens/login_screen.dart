import 'package:dalili_app/src/utils/constants.dart';
import 'package:dalili_app/src/widgets/login/home_button.dart';
import 'package:dalili_app/src/widgets/login/login_body.dart';
import 'package:dalili_app/src/widgets/login/login_logo.dart';
import 'package:flutter/material.dart';
import 'package:dalili_app/src/utils/dimentions_utils.dart' as dim;

class LoginScreen extends StatelessWidget {
  static const String path = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primary75],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            LoginLogo(),
            HomeButton(),
            LoginBody(),
          ],
        ),
      ),
    );
  }
}
