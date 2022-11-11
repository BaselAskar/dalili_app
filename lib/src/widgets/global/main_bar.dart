import 'package:dalili_app/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class MainBar extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  MainBar({this.scaffoldKey = null});

  @override
  State<MainBar> createState() => _MainBarState();
}

class _MainBarState extends State<MainBar> {
  @override
  Widget build(BuildContext context) {
    double statusBar = MediaQuery.of(context).padding.top;

    bool _isLogin = Provider.of<Auth>(context).isLogin;

    return Container(
      width: double.infinity,
      height: statusBar + Dimentions.mainBarHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primary75],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Container(
        margin: EdgeInsets.only(top: statusBar),
        child: Row(
          mainAxisAlignment: widget.scaffoldKey != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            Container(
              height: Dimentions.logoHeight,
              child: Image.asset('assets/images/logo.png'),
            ),
            if (widget.scaffoldKey != null)
              if (!_isLogin)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextButton(
                    onPressed: () =>
                        widget.scaffoldKey?.currentState?.openEndDrawer(),
                    child: Row(
                      children: [
                        const Text(
                          'تسجيل الدخول',
                          style: TextStyle(color: AppColors.loginColor),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.account_circle,
                          color: AppColors.loginColor,
                          size: 35,
                        )
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
