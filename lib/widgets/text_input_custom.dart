import 'package:flutter/material.dart';
import 'package:shop/constants/colors.dart';

class TextInputCustom extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color placeholderColor;
  final Color borderColor;
  final IconData icon;
  final Color iconColor;
  final bool typePassword;
  final void Function() onEditingComplete;
  final TextEditingController controller;

  TextInputCustom({
    @required this.label,
    this.textColor = colorDarkGray,
    this.placeholderColor = colorBrown,
    this.borderColor = colorBrown,
    @required this.icon,
    this.iconColor = colorBrown,
    this.typePassword = false,
    this.onEditingComplete,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: placeholderColor,
      onEditingComplete: onEditingComplete,
      style: TextStyle(
        color: textColor,
      ),
      obscureText: typePassword,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(
          color: placeholderColor,
          fontSize: 16.0,
        ),
        focusColor: textColor,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        contentPadding: EdgeInsets.all(20.0),
        // filled: true,
        // fillColor: colorGray,
        prefixIcon: Icon(icon, color: iconColor),
      ),
    );
  }
}
