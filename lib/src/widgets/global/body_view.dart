import 'package:flutter/material.dart';

class BodyView extends StatelessWidget {
  final List<Widget> children;
  final double height;

  BodyView({required this.children, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: children,
      ),
    );
  }
}
