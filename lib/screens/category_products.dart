import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop/blocs/details_bloc.dart';
import 'package:shop/constants/colors.dart';
import 'package:shop/util/formatPrice.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/screens/details.dart';

class CategoryProducts extends StatefulWidget {
  final List<CategoryModel> categories;
  final int categoryIndexTarget;

  CategoryProducts({this.categories, this.categoryIndexTarget});

  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  int categorySelected;
  List<ProductModel> _productsData;
  final ScrollController _scrollListViewController = ScrollController();

  void _productsByCategory() async {
    try {
      Dio dio = Dio();
      Response response;

      var findCategoryName = widget.categories[categorySelected].name;

      response = await dio.get(
        'http://192.168.2.8:3333/product/index',
        queryParameters: {
          'category': findCategoryName,
        },
      );

      var productsData = (response.data as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();

      setState(() {
        _productsData = productsData;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();

    categorySelected = widget.categoryIndexTarget;

    _productsByCategory();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToItem(categorySelected);
    });
  }

  void _scrollToItem(int currentIndex) {
    _scrollListViewController.animateTo(
      (currentIndex * 70).toDouble(),
      duration: Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DetailsBloc detailsBloc = Provider.of<DetailsBloc>(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('/'),
                  icon: Icon(
                    Feather.align_left,
                    color: colorBlack,
                    size: 30.0,
                  ),
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pushNamed('/cart'),
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
                          detailsBloc.amountItemsOnCart.toString(),
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
              'Veja todos os produtos selecionados',
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
              controller: _scrollListViewController,
              itemCount: widget.categories.length,
              itemBuilder: (BuildContext context, int index) {
                CategoryModel category = widget.categories[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      categorySelected = index;
                      _productsByCategory();
                      _scrollToItem(index);
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
                            color: categorySelected == index
                                ? colorDarkGray
                                : colorBlueGray,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        CircleAvatar(
                          backgroundColor: categorySelected == index
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
            child: _productsData != null && _productsData.length != 0
                ? Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _productsData.length,
                      itemBuilder: (BuildContext context, int index) {
                        ProductModel product = _productsData[index];

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
                            tag: product.id,
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  width: 200.0,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                      image:
                                          NetworkImage(product.images[0].url),
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
                                        formatPrice(product.price),
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
                  )
                : Center(
                    child: Text(
                      'Nenhum produto localizado',
                      style: TextStyle(
                        color: colorBlueGray,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
          ),
        ],
      ),
      backgroundColor: colorWhite,
    );
  }
}
