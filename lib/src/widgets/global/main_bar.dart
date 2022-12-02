import 'package:dalili_app/src/providers/auth_provider.dart';
import 'package:dalili_app/src/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class MainBar extends StatefulWidget {
  final bool showUser;

  MainBar({this.showUser = false});

  @override
  State<MainBar> createState() => _MainBarState();
}

class _MainBarState extends State<MainBar> {
  bool _init = false;

  //states
  String? _userName;
  String? _photoUrl;

  Future<void> _getUser(BuildContext context) async {
    final user = await Provider.of<Auth>(context).user;

    setState(() {
      if (user!.containsKey('userName') && user['userName'] != null) {
        _userName = user['userName'];
      }

      if (user.containsKey('photoUrl')) {
        _photoUrl = user['photoUrl'];
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_init) {
      _getUser(context);
      _init = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double statusBar = MediaQuery.of(context).padding.top;

    Future<bool> _isLogin = Provider.of<Auth>(context).isLogin;

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
          mainAxisAlignment: widget.showUser
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            Container(
              height: Dimentions.logoHeight,
              child: Image.asset('assets/images/logo.png'),
            ),
            if (widget.showUser)
              FutureBuilder(
                  future: _isLogin,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.waiting &&
                        snapshot.data == true) {
                      return TextButton(
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: Row(
                          children: [
                            if (_userName != null)
                              Text(
                                _userName!,
                                style: const TextStyle(
                                  color: AppColors.loginColor,
                                ),
                              ),
                            SizedBox(
                              width: 10,
                            ),
                            if (_photoUrl != null)
                              CircleAvatar(
                                  backgroundImage: NetworkImage(_photoUrl!)),
                            if (_photoUrl == null)
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/user.png'),
                              )
                          ],
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SpinKitPianoWave(size: 30, color: Colors.white);
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.path),
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
                    );
                  }),
          ],
        ),
      ),
    );
  }
}
