import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shop/constants/colors.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/screens/category_products.dart';
import 'package:shop/screens/home_page.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          icon: Icon(
            MaterialCommunityIcons.keyboard_backspace,
            color: colorBlack,
            size: 30.0,
          ),
        ),
        title: Text(
          'Categories',
          style: TextStyle(
            color: colorBlack,
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 60.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            CategoriesModel category = categories[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryProducts(item: index),
                  ),
                );
              },
              child: Container(
                height: 180.0,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: colorBlueGray,
                      offset: Offset(0.0, 5.0),
                    ),
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(category.backgroundUrl),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      category.name,
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: colorWhite,
    );
  }
}
