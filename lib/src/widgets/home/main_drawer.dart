import 'package:dalili_app/src/screens/favorit_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final String? _userPhotoUrl;
  final Future<void> Function(BuildContext context) _logout;

  MainDrawer(this._userPhotoUrl, this._logout);

  @override
  Widget build(BuildContext context) {
    double statusbar = MediaQuery.of(context).padding.top;

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(top: statusbar + 20, bottom: 40),
            child: CircleAvatar(
              backgroundImage: _userPhotoUrl != null
                  ? NetworkImage(_userPhotoUrl as String)
                  : Image.asset('assets/images/user.png').image,
              radius: 60,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10)),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(width: 10),
                      Text('المعلومات الشخصية'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10)),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(FavoritScreen.path),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 10),
                      Text('المنتجات المهتم بها'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                    onPressed: () => _logout(context),
                    child: const Text(
                      'تسجيل خروج',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
