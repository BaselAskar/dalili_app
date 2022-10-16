import 'package:flutter/material.dart';

class CutomeFutureBuilder extends StatefulWidget {
  final Future<dynamic>? future;
  final Widget Function(dynamic data) successBuilder;
  final Widget? Function(dynamic error)? errorBuilder;
  final Widget? loadingBuilder;

  CutomeFutureBuilder({
    this.future,
    required this.successBuilder,
    this.errorBuilder,
    this.loadingBuilder,
  });

  @override
  State<CutomeFutureBuilder> createState() => _CutomeFutureBuilderState();
}

class _CutomeFutureBuilderState extends State<CutomeFutureBuilder> {
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
