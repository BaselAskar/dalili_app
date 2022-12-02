import 'package:flutter/material.dart';

class BodyView extends StatelessWidget {
  final List<Widget> children;

  BodyView({required this.children});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: children,
    );
  }
}
