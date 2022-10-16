import 'package:flutter/material.dart';

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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  onPressed: () {
                    widget.scaffoldKey?.currentState?.openEndDrawer();
                  },
                  icon: const Icon(
                    Icons.account_box_rounded,
                    color: Colors.blueGrey,
                    size: 30,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
