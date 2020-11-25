import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shop/constants/colors.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/screens/home_page.dart';

class Details extends StatefulWidget {
  final ProductsModel product;

  Details({this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool _toggleLikeProduct = false;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final double _sizeHeight = MediaQuery.of(context).size.height;
    final double _sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      MaterialCommunityIcons.keyboard_backspace,
                      color: colorBlack,
                      size: 30.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _toggleLikeProduct = !_toggleLikeProduct;
                      });
                    },
                    icon: _toggleLikeProduct
                        ? Icon(
                            MaterialCommunityIcons.heart,
                            color: colorRed,
                            size: 30.0,
                          )
                        : Icon(
                            MaterialCommunityIcons.heart_outline,
                            color: colorBlack,
                            size: 30.0,
                          ),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Hero(
                  tag: widget.product.imageUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    child: Container(
                      height: _sizeHeight * 0.5,
                      width: _sizeWidth,
                      child: PageView.builder(
                        onPageChanged: (int indexChangedPage) {
                          setState(() {
                            _currentPage = indexChangedPage;
                          });
                        },
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            widget.product.imageUrl,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  child: Row(
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: CircleAvatar(
                          radius: 6.0,
                          backgroundColor: _currentPage == index
                              ? colorBrown
                              : colorWhite.withAlpha(100),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
              color: colorWhite,
              constraints: BoxConstraints(
                minHeight: _sizeHeight * 0.5 - 80.0,
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Title of product',
                            style: TextStyle(
                              color: colorBlack,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$34.00',
                            style: TextStyle(
                              color: colorBlack,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 100.0,
                        child: Scrollbar(
                          radius: Radius.circular(5.0),
                          thickness: 3.0,
                          child: SingleChildScrollView(
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                              // 'Lorem ipsum dolor sit amet',
                              style: TextStyle(
                                color: colorDarkGray,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      height: 70.0,
                      width: _sizeWidth - 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: RaisedButton(
                          onPressed: () {},
                          color: colorBlack,
                          elevation: 0.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                AntDesign.shoppingcart,
                                color: colorWhite,
                                size: 30.0,
                              ),
                              SizedBox(width: 15.0),
                              Text(
                                'Add to cart',
                                style: TextStyle(
                                  color: colorWhite,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: colorWhite,
    );
  }
}
