import 'package:flutter/material.dart';
import 'package:shop/screens/cart.dart';
import 'package:shop/screens/categories.dart';
import 'package:shop/screens/category_products.dart';
import 'package:shop/screens/details.dart';
import 'package:shop/screens/home_page.dart';
import 'constants/colors.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop',
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        primaryColor: colorWhite,
        accentColor: colorBrown,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
        ),
      ),
    ),
  );
}
