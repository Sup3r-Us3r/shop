import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:math';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop/blocs/user_bloc.dart';
import 'package:shop/constants/colors.dart';
import 'package:shop/util/formatPrice.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/blocs/details_bloc.dart';

class HomePage extends StatelessWidget {
  Future<List<ProductModel>> _getProducts() async {
    Dio dio = Dio();
    Response response;

    response = await dio.get('http://192.168.2.8:3333/product/index');

    var productsData = (response.data as List)
        .map((product) => ProductModel.fromJson(product))
        .toList();

    return productsData;
  }

  Container productList(List<ProductModel> productData, BuildContext context) {
    Random random = Random();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 30.0,
        mainAxisSpacing: 40.0,
        itemCount: productData.length,
        itemBuilder: (BuildContext context, int index) {
          ProductModel product = productData[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/details', arguments: product);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: Hero(
                    tag: product.id,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: product.images[0].url,
                      fit: BoxFit.cover,
                      height: (random.nextInt(300) + 200).toDouble(),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  // transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    color: colorWhite,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10.0,
                        color: colorBlueGray,
                        offset: Offset(0.0, 5.0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          color: colorBlack,
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        formatPrice(product.price),
                        style: TextStyle(
                          color: colorBrown,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 5.0),
              ],
            ),
          );
        },
        staggeredTileBuilder: (int index) {
          return StaggeredTile.fit(1);
        },
      ),
    );
  }

  void _signOut(BuildContext context) async {
    final UserBloc _userBloc = Provider.of<UserBloc>(context, listen: false);

    var response = await _userBloc.signOut();

    if (response) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/signIn',
        (route) => false,
      );
    }
  }

  SnackBar _exitToApp(BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      backgroundColor: colorBlack.withAlpha(200),
      duration: Duration(seconds: 5),
      content: Text(
        'Deseja sair?',
        style: TextStyle(
          color: colorWhite,
          fontSize: 16.0,
        ),
      ),
      action: SnackBarAction(
        label: 'SAIR',
        onPressed: () => _signOut(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserBloc _userBloc = Provider.of<UserBloc>(context);
    final DetailsBloc _detailsBloc = Provider.of<DetailsBloc>(context);
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () {
                        Scaffold.of(context).showSnackBar(
                          _exitToApp(context),
                        );
                      },
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                          _userBloc.userData.photo.url,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pushNamed(
                          '/categories',
                        ),
                        icon: Icon(
                          Ionicons.ios_list,
                          color: colorBlack,
                          size: 30.0,
                        ),
                      ),
                      Stack(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).pushNamed(
                              '/favoriteProducts',
                            ),
                            icon: Icon(
                              MaterialCommunityIcons.heart_outline,
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
                                _detailsBloc.quantityOfFavoriteProducts
                                    .toString(),
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
                      Stack(
                        children: [
                          IconButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/cart'),
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
                                _detailsBloc.amountItemsOnCart.toString(),
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
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Principais produtos em destaque',
                style: TextStyle(
                  color: colorBlack,
                  fontSize: 30.0,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Container(
              height: 70.0,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              margin: EdgeInsets.only(
                left: 40.0,
                top: 30.0,
                bottom: 30.0,
              ),
              decoration: BoxDecoration(
                color: colorGray,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    AntDesign.search1,
                    color: colorDarkGray,
                    size: 25.0,
                  ),
                  SizedBox(width: 5.0),
                  Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: colorBrown,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Pesquisar...',
                        hintStyle: TextStyle(
                          color: colorDarkGray,
                          fontSize: 18.0,
                        ),
                      ),
                      style: TextStyle(
                        color: colorDarkGray,
                        fontSize: 18.0,
                      ),
                      controller: _searchController,
                      onSubmitted: (String inputValue) {
                        Navigator.of(context).pushNamed(
                          '/researchedProducts',
                          arguments: inputValue,
                        );
                        _searchController.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: _getProducts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                    return productList(snapshot.data, context);
                  default:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
          ],
        ),
      ),
      backgroundColor: colorWhite,
    );
  }
}
