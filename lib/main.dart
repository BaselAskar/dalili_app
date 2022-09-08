import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dalili_app/src/utils/constants.dart';
import 'package:flutter/services.dart';

import './src/widgets/global/main_bar.dart';
import './src/widgets/home/classifications.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> list = [];

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    list = [];
    for (int i = 0; i < 50; i++) {
      list.add('list ${i + 1}');
    }
    double screenHeight = MediaQuery.of(context).size.height;
    double statusbarPadding = MediaQuery.of(context).padding.top;

    double bodyHeight = screenHeight - statusbarPadding - 70;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
          child: Column(
        children: const [
          Expanded(
            child: Center(
              child: Text('List'),
            ),
          )
        ],
      )),
      body: Column(children: [
        MainBar(
          _scaffoldKey,
        ),
        Container(
          height: bodyHeight - MediaQuery.of(context).padding.bottom,
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              Classifications(),
            ],
          ),
        )
      ]),
    );
  }
}
