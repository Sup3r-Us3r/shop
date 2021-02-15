import 'package:flutter/material.dart';
import 'package:shop/constants/colors.dart';

class TextInputCustom extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool typePassword;
  final TextEditingController controller;

  TextInputCustom({
    @required this.label,
    @required this.icon,
    this.typePassword = false,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: colorBrown,
      style: TextStyle(
        color: colorDarkGray,
      ),
      obscureText: typePassword,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(
          color: colorBrown,
          fontSize: 16.0,
        ),
        focusColor: colorRed,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: colorBrown,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: colorBrown,
          ),
        ),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(5.0),
        //   borderSide: BorderSide.none,
        // ),
        contentPadding: EdgeInsets.all(20.0),
        // filled: true,
        // fillColor: colorGray,
        prefixIcon: Icon(
          icon,
          color: colorBrown,
        ),
      ),
    );
  }
}
