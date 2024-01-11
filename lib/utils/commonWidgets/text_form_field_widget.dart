import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Iterable<String> autofillHints;
  final bool obscureText;
  final TextInputType keyboardType;
  final String hintText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Function() onPressed;
  final Function(String) validator;
  final Function(String) onChanged;
  const TextFormFieldWidget({
    Key key,
    this.controller,
    this.autofillHints,
    this.obscureText,
    this.keyboardType,
    this.hintText,
    this.onPressed,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: autofillHints,
      controller: controller,
      autofocus: false,
      cursorColor: Colors.green.shade800,
      obscureText: false ?? obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      //   style:  ThemeText.passwordText,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintMaxLines: 1,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.green.shade800)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.green.shade800)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.green.shade800)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.green.shade800)),
      ),
      validator: validator,
      //   onSaved: (value) => _password = value!.trim(),
    );
  }
}
