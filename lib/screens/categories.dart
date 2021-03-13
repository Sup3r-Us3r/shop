import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:shop/constants/colors.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/screens/category_products.dart';
import 'package:transparent_image/transparent_image.dart';

class Categories extends StatelessWidget {
  Future<List<CategoryModel>> _getCategories() async {
    Dio dio = Dio();
    Response response;

    response = await dio.get('http://192.168.2.8:3333/category/index');

    var categoriesData = (response.data as List)
        .map((category) => CategoryModel.fromJson(category))
        .toList();

    return categoriesData;
  }

  Widget categoriesList(
    List<CategoryModel> categoriesData,
    BuildContext context,
  ) {
    return ListView.builder(
      itemCount: categoriesData.length,
      itemBuilder: (BuildContext context, int index) {
        CategoryModel category = categoriesData[index];

        return GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            '/categoryProducts',
            arguments: CategoryProducts(
              categories: categoriesData,
              categoryIndexTarget: index,
            ),
          ),
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
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: category.image.url,
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
    );
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
          'Categorias',
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
        child: FutureBuilder(
          future: _getCategories(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return categoriesList(snapshot.data, context);
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
      backgroundColor: colorWhite,
    );
  }
}
