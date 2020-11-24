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

  @override
  Widget build(BuildContext context) {
    final double sizeHeight = MediaQuery.of(context).size.height;
    final double sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: widget.product.imageUrl,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  child: Image.network(
                    widget.product.imageUrl,
                    height: sizeHeight * 0.5,
                    width: sizeWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
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
                        MaterialCommunityIcons.keyboard_backspace,
                        color: colorWhite,
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
                              color: colorWhite,
                              size: 30.0,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
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
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        style: TextStyle(
                          color: colorDarkGray,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      height: 70.0,
                      width: sizeWidth - 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
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
          ),
        ],
      ),
      backgroundColor: colorWhite,
    );
  }
}
