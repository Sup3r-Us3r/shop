import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shop/constants/colors.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/util/formatPrice.dart';
import 'package:transparent_image/transparent_image.dart';

class ResearchedProducts extends StatelessWidget {
  final String query;

  ResearchedProducts({this.query});

  Future<List<ProductModel>> _getProducts() async {
    Dio dio = Dio();
    Response response;

    response = await dio.get('http://192.168.2.8:3333/product/index');

    var productData = (response.data as List)
        .map((product) => ProductModel.fromJson(product))
        .toList();
    // .where((product) => product.name.contains(this.widget.query));

    return productData;
  }

  Widget _renderResearchedProducts(
    BuildContext context,
    List<ProductModel> productData,
  ) {
    return ListView.builder(
      itemCount: productData.length,
      itemBuilder: (BuildContext context, int index) {
        ProductModel product = productData[index];

        return GestureDetector(
          onTap: () =>
              Navigator.of(context).pushNamed('/details', arguments: product),
          child: Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: colorBlueGray,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 5.0),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: product.images[0].url,
                    fit: BoxFit.cover,
                    height: 80.0,
                    width: 80.0,
                  ),
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      formatPrice(product.price),
                      style: TextStyle(
                        color: colorBrown,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    onPressed: () => null,
                    icon: Icon(
                      MaterialCommunityIcons.eye,
                      color: colorBrown,
                    ),
                  ),
                ),
              ],
            ),
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
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            MaterialCommunityIcons.keyboard_backspace,
            color: colorBlack,
            size: 30.0,
          ),
        ),
        title: Text(
          'Produtos encontrados',
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
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                // color: colorGray,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: FutureBuilder(
                future: _getProducts(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<ProductModel>> snapshot,
                ) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return CircularProgressIndicator(
                        backgroundColor: colorBrown,
                      );
                    case ConnectionState.done:
                      return snapshot.data.length == 0
                          ? Center(
                              child: Text(
                                'Nenhum produto localizado',
                                style: TextStyle(
                                  color: colorBlueGray,
                                  fontSize: 20.0,
                                ),
                              ),
                            )
                          : _renderResearchedProducts(context, snapshot.data);
                    default:
                      return CircularProgressIndicator(
                        backgroundColor: colorBrown,
                      );
                  }
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
