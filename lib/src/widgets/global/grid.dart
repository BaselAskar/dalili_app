// import 'dart:core' as core;
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  final int numOfCol;
  final List<Widget> children;
  final double mainAxisSpeacing;
  final double crossAxisSpeacing;

  Grid({
    this.numOfCol = 1,
    required this.children,
    this.mainAxisSpeacing = 0,
    this.crossAxisSpeacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    int numOfRows = (children.length / numOfCol).ceil();

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: List.generate(numOfRows, (indexRow) {
          return Row(
            children: List.generate(numOfCol, (indexCol) {
              final int index = (numOfCol * indexRow) + indexCol;

              return Container(
                padding: EdgeInsets.only(
                    left: indexCol != 0 ? mainAxisSpeacing / 2 : 0,
                    right: indexCol != numOfCol - 1 ? mainAxisSpeacing / 2 : 0,
                    top: indexRow != 0 ? mainAxisSpeacing / 2 : 0,
                    bottom:
                        indexRow != numOfRows - 1 ? mainAxisSpeacing / 2 : 0),
                width: (constraints.maxWidth / numOfCol),
                child: index < children.length ? children[index] : Container(),
              );
            }),
          );
        }),
      );
    });
  }
}

buildGrid(
    {int numOfCol = 1,
    List<Widget>? children = null,
    double mainAxisSpeacing = 0,
    double crossAxisSpeacing = 0}) {
  int numOfRows = children != null ? (children.length / numOfCol).ceil() : 0;

  return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
    return Column(
      children: List.generate(numOfRows, (indexRow) {
        return Row(
          children: List.generate(numOfCol, (indexCol) {
            return Container(
              padding: EdgeInsets.only(
                  left: indexCol != 0 ? mainAxisSpeacing / 2 : 0,
                  right: indexCol != numOfCol - 1 ? mainAxisSpeacing / 2 : 0,
                  top: indexRow != 0 ? mainAxisSpeacing / 2 : 0,
                  bottom: indexRow != numOfRows - 1 ? mainAxisSpeacing / 2 : 0),
              width: (constraints.maxWidth / numOfCol),
              child: children != null
                  ? children[(numOfCol * indexRow) + indexCol]
                  : null,
            );
          }),
        );
      }),
    );
  });
}
