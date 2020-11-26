import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop/constants/colors.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/screens/category_products.dart';
import 'package:transparent_image/transparent_image.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80.0,
        elevation: 0.3,
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
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    height: 180.0,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: isLoading
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: colorWhite,
                              child: Card(color: colorGray),
                            )
                          : Image.network(
                              category.backgroundUrl,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    left: 20.0,
                    child: Text(
                      category.name,
                      style: TextStyle(
                        color: colorWhite,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      backgroundColor: colorWhite,
    );
  }
}
