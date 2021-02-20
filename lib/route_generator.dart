import 'package:flutter/material.dart';
import 'package:shop/constants/colors.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/screens/cart.dart';
import 'package:shop/screens/categories.dart';
import 'package:shop/screens/category_products.dart';
import 'package:shop/screens/details.dart';
import 'package:shop/screens/favorite_products.dart';
import 'package:shop/screens/home_page.dart';
import 'package:shop/screens/researched_products.dart';
import 'package:shop/screens/sign_in.dart';
import 'package:shop/screens/sign_up.dart';

class RouteGenerator {
  static Route<dynamic> routeGenerator(RouteSettings settings) {
    final _args = settings.arguments;

    switch (settings.name) {
      case '/signIn':
        return MaterialPageRoute(builder: (_) => SignIn());
      case '/signUp':
        return MaterialPageRoute(builder: (_) => SignUp());
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/categories':
        return MaterialPageRoute(builder: (_) => Categories());
      case '/favoriteProducts':
        return MaterialPageRoute(builder: (_) => FavoriteProducts());
      case '/cart':
        return MaterialPageRoute(builder: (_) => Cart());
      case '/details':
        {
          if (_args == null) {
            return _errorRoute('Arguments is required');
          }

          if (_args is ProductModel) {
            return MaterialPageRoute(builder: (_) => Details(product: _args));
          }

          return _errorRoute('Arguments have incorret data type');
        }
      case '/categoryProducts':
        {
          final CategoryProducts _categoryProdutsArgs = settings.arguments;

          if (_categoryProdutsArgs == null) {
            return _errorRoute('Arguments is required');
          }

          if (_categoryProdutsArgs.categories is List<CategoryModel> &&
              _categoryProdutsArgs.categoryIndexTarget is int) {
            return MaterialPageRoute(
              builder: (_) => CategoryProducts(
                categories: _categoryProdutsArgs.categories,
                categoryIndexTarget: _categoryProdutsArgs.categoryIndexTarget,
              ),
            );
          }

          return _errorRoute('Arguments have incorret data type');
        }
      case '/researchedProducts':
        {
          if (_args == null) {
            return _errorRoute('Arguments is required');
          }

          if (_args is String) {
            return MaterialPageRoute(
              builder: (_) => ResearchedProducts(query: _args),
            );
          }

          return _errorRoute('Arguments have incorret data type');
        }
      default:
        return _errorRoute('Named route not found');
    }
  }

  static Route<dynamic> _errorRoute(String messageError) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text(
            messageError,
            style: TextStyle(
              color: colorRed,
              fontSize: 18.0,
            ),
          ),
        ),
        backgroundColor: colorWhite,
      );
    });
  }
}
