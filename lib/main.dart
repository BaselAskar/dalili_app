import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './src/screens/home_screen.dart';
import './src/screens/store_screen.dart';
import './src/screens/product_screen.dart';
import './src/screens/photo_view_screen.dart';
import './src/screens/home_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dalili',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        HomeScreen.path: (context) => HomeScreen(),
        StoreScreen.path: (context) => StoreScreen(),
        ProductScreen.path: (context) => ProductScreen(),
        PhotoViewScreen.path: (context) => PhotoViewScreen(),
      },
    );
  }
}
