import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop/blocs/details_bloc.dart';
import 'package:shop/constants/colors.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/util/formatPrice.dart';

class Details extends StatelessWidget {
  final ProductModel product;

  Details({this.product});

  @override
  Widget build(BuildContext context) {
    final DetailsBloc _detailsBloc = Provider.of<DetailsBloc>(context);
    _detailsBloc.currentProductData(product);

    final double _sizeHeight = MediaQuery.of(context).size.height;
    final double _sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    MaterialCommunityIcons.keyboard_backspace,
                    color: colorBlack,
                    size: 30.0,
                  ),
                ),
                IconButton(
                  onPressed: () => _detailsBloc.toggleLikeProduct(),
                  icon: _detailsBloc.showCurrentProductInfo('likeProduct')
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
                tag: product.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  child: Container(
                    height: _sizeHeight * 0.5,
                    width: _sizeWidth,
                    child: PageView.builder(
                      onPageChanged: (int indexChangedPage) =>
                          _detailsBloc.whenPageChanged(indexChangedPage),
                      itemCount: product.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InteractiveViewer(
                          child: Image.network(
                            product.images[index].url,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20.0,
                child: Row(
                  children: List.generate(product.images.length, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: CircleAvatar(
                        radius: 6.0,
                        backgroundColor: _detailsBloc
                                    .showCurrentProductInfo('currentPage') ==
                                index
                            ? colorBrown
                            : colorWhite.withAlpha(100),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
                color: colorWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '1 cada',
                      style: TextStyle(
                        color: colorDarkGray,
                        fontSize: 20.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 10.0,
                            ),
                            decoration: BoxDecoration(
                              color: colorGray,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      _detailsBloc.decrementProduct(),
                                  icon: Icon(
                                    AntDesign.minus,
                                    color: colorBlack,
                                    size: 20.0,
                                  ),
                                ),
                                SizedBox(width: 20.0),
                                Text(
                                  _detailsBloc
                                      .showCurrentProductInfo('amountValue')
                                      .toString(),
                                  style: TextStyle(
                                    color: colorBlack,
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(width: 20.0),
                                IconButton(
                                  onPressed: () =>
                                      _detailsBloc.incrementProduct(),
                                  icon: Icon(
                                    AntDesign.plus,
                                    color: colorBlack,
                                    size: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            _detailsBloc.showCurrentProductInfo('totalPrice') !=
                                    ''
                                ? _detailsBloc
                                    .showCurrentProductInfo('totalPrice')
                                : formatPrice(product.price),
                            style: TextStyle(
                              color: colorBlack,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Descrição do produto',
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 20.0,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: 100.0,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      child: SingleChildScrollView(
                        child: Text(
                          product.description,
                          style: TextStyle(
                            color: colorDarkGray,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 70.0,
                      width: _sizeWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: ElevatedButton(
                          onPressed: () => _detailsBloc.toggleProductInCart(),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              colorBrown,
                            ),
                            elevation: MaterialStateProperty.all<double>(0.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                !_detailsBloc.productAddedOnCart
                                    ? MaterialCommunityIcons.cart_plus
                                    : MaterialCommunityIcons.cart_remove,
                                color: colorWhite,
                                size: 30.0,
                              ),
                              SizedBox(width: 15.0),
                              Text(
                                !_detailsBloc.productAddedOnCart
                                    ? 'Adicionar ao carrinho'
                                    : 'Remover do carrinho',
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
                  ],
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
