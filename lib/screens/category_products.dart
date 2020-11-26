import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shop/constants/colors.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/screens/details.dart';
import 'package:shop/screens/home_page.dart';

class CategoryProducts extends StatefulWidget {
  final int item;

  CategoryProducts({this.item});

  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  int itemSelected;

  @override
  void initState() {
    super.initState();

    itemSelected = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  icon: Icon(
                    Feather.align_left,
                    color: colorBlack,
                    size: 30.0,
                  ),
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        AntDesign.shoppingcart,
                        color: colorBlack,
                        size: 30.0,
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      child: CircleAvatar(
                        backgroundColor: colorBrown,
                        radius: 12.0,
                        child: Text(
                          '21',
                          style: TextStyle(
                            color: colorWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'The best products of Natura',
              style: TextStyle(
                color: colorBlack,
                fontSize: 30.0,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Container(
            height: 80.0,
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                CategoriesModel category = categories[index];

                return GestureDetector(
                  onTap: () {
                    print(category.name);
                    setState(() {
                      itemSelected = index;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          category.name,
                          style: TextStyle(
                            color: itemSelected == index
                                ? colorDarkGray
                                : colorBlueGray,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        CircleAvatar(
                          backgroundColor: itemSelected == index
                              ? colorBrown
                              : colorBlueGray,
                          radius: 3.0,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productsList.length,
                itemBuilder: (BuildContext context, int index) {
                  ProductsModel product = productsList[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            product: product,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: product.imageUrl,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                            width: 200.0,
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                image: NetworkImage(product.imageUrl),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7.0,
                                  color: colorBlack.withOpacity(0.1),
                                  offset: Offset(7.0, 0.0),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 20.0,
                            left: 40.0,
                            child: Container(
                              height: 40.0,
                              width: 110.0,
                              decoration: BoxDecoration(
                                color: colorWhite.withAlpha(150),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  product.price,
                                  style: TextStyle(
                                    color: colorBlack,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: colorWhite,
    );
  }
}
