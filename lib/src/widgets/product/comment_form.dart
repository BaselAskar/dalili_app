import 'package:flutter/material.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({Key? key}) : super(key: key);

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(Icons.send),
          TextField(),
        ],
      ),
    );
  }
}
