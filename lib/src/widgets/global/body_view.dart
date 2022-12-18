import 'package:flutter/material.dart';

class BodyView extends StatelessWidget {
  final double height;
  final List<Widget> children;

  BodyView({required this.height, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: children,
      ),
    );
  }
}
