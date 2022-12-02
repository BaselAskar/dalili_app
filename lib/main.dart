import 'package:dalili_app/src/providers/auth_provider.dart';
import 'package:dalili_app/src/providers/http_provider.dart';
import 'package:dalili_app/src/screens/login_screen.dart';
import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './src/screens/home_screen.dart';
import './src/screens/search_section_screen.dart';
import './src/screens/store_screen.dart';
import './src/screens/product_screen.dart';
import './src/screens/photo_view_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HttpProvider()),
        ChangeNotifierProvider.value(value: Auth()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dalili',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: AppColors.primary,
        ),
        initialRoute: '/',
        routes: {
          HomeScreen.path: (context) => HomeScreen(),
          SearchSectionScreen.path: (context) => SearchSectionScreen(),
          StoreScreen.path: (context) => StoreScreen(),
          ProductScreen.path: (context) => ProductScreen(),
          PhotoViewScreen.path: (context) => PhotoViewScreen(),
          LoginScreen.path: (context) => LoginScreen(),
        },
      ),
    );
  }
}
