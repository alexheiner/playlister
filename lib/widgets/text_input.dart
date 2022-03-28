import 'package:flutter/material.dart';
import '/config/themes/colors.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final IconData? icon;
  final bool autoFocus;
  TextInput(
    { 
      this.autoFocus = false,
      required this.controller,
      required this.placeholder,
      this.icon,
      Key? key
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      controller: controller,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        filled: true,
        fillColor: OpaqueGray,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        prefixIcon: 
        icon != null ?
          Icon(
            icon,
            color: Colors.white,
          ): null,
      ),
    );
  }
}