import 'package:flutter/material.dart';

class CustomeFutureBuilder extends StatefulWidget {
  final Future<dynamic>? future;
  final Widget Function(dynamic data) successBuilder;
  final Widget? Function(dynamic error)? errorBuilder;
  final Widget? loadingBuilder;

  CustomeFutureBuilder({
    this.future,
    required this.successBuilder,
    this.errorBuilder,
    this.loadingBuilder,
  });

  @override
  State<CustomeFutureBuilder> createState() => _CustomeFutureBuilderState();
}

class _CustomeFutureBuilderState extends State<CustomeFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingBuilder ?? SizedBox();
        } else if (snapshot.hasData) {
          return widget.successBuilder(snapshot.data);
        } else if (snapshot.hasError) {
          return widget.errorBuilder!(snapshot.error) ?? SizedBox();
        }

        return Text('Wrong builder');
      },
    );
  }
}
