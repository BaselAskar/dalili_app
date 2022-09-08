import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utils/constants.dart';

class MainBar extends StatefulWidget {
  final GlobalKey<ScaffoldState>? _key;

  MainBar(this._key);

  @override
  State<MainBar> createState() => _MainBarState();
}

class _MainBarState extends State<MainBar> {
  @override
  Widget build(BuildContext context) {
    double statusBar = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      height: statusBar + 70,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primary75],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Container(
        margin: EdgeInsets.only(top: statusBar),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            height: 40,
            child: Image.asset('assets/images/logo.png'),
          ),
          IconButton(
            onPressed: () {
              widget._key?.currentState?.openEndDrawer();
            },
            icon: const Icon(
              Icons.account_box,
            ),
          )
        ]),
      ),
    );
  }
}
