import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final EdgeInsets contentPadding;
  final InputBorder inputBorder;
  final TextInputType keyboardType;
  final void Function(String value) onChanged;
  final String Function(String) validator;

  const CustomTextFormField({
    Key key,
    this.controller,
    this.obscureText = false,
    this.labelText,
    this.contentPadding = const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    this.inputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    this.keyboardType, this.validator, this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: contentPadding,
        border: inputBorder,
      ),
    );
  }
}
