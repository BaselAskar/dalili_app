import 'package:flutter/material.dart';

enum TextType { text, password }

class LoginField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final FocusNode? focusNode;
  final bool isLastField;
  final String? Function(String? value)? validator;
  final void Function(String vaule)? onFieldSubmitted;
  final void Function(String? value)? onSave;
  final TextType type;
  final TextInputType? keyboartType;

  LoginField({
    this.controller,
    required this.labelText,
    this.type = TextType.text,
    this.focusNode,
    this.isLastField = false,
    this.validator,
    this.onFieldSubmitted,
    this.onSave,
    this.keyboartType,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: 300,
        child: TextFormField(
          keyboardType: keyboartType,
          onSaved: onSave,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction:
              isLastField ? TextInputAction.done : TextInputAction.next,
          validator: validator,
          focusNode: focusNode,
          style: TextStyle(decoration: TextDecoration.none, fontSize: 18),
          obscureText: type == TextType.password,
          enableSuggestions: !(type == TextType.password),
          autocorrect: !(type == TextType.password),
          textDirection: TextDirection.rtl,
          controller: controller,
          decoration: InputDecoration(
            label: Text(
              labelText,
              textDirection: TextDirection.rtl,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
          ),
        ),
      ),
    );
  }
}
