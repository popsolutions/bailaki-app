import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final String initialValue;
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
    this.initialValue,
    this.contentPadding = const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    this.inputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    this.keyboardType,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      initialValue: initialValue,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey,
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
        helperStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
        labelText: labelText,
        contentPadding: contentPadding,
        border: inputBorder,
      ),
    );
  }
}
