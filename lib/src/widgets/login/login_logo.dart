import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Center(
        child: Container(
          width: 300,
          child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
        ),
      ),
    );
  }
}
