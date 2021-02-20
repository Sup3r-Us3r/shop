import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop/blocs/details_bloc.dart';
import 'package:shop/constants/colors.dart';
import 'package:shop/models/product_details_model.dart';
import 'package:shop/util/formatPrice.dart';
import 'package:transparent_image/transparent_image.dart';

class Cart extends StatelessWidget {
  ListView _renderProductsOnCart(BuildContext context) {
    final DetailsBloc detailsBloc = Provider.of<DetailsBloc>(context);

    return ListView.builder(
      itemCount: detailsBloc.amountItemsOnCart,
      itemBuilder: (BuildContext context, int index) {
        ProductDetailsModel product = detailsBloc.cart[index];

        return GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            '/details',
            arguments: product,
          ),
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
                      '${formatPrice(product.price)}  x  ${product.amountValue}',
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
                    onPressed: () =>
                        detailsBloc.removeProductOnCart(product.id),
                    icon: Icon(
                      Feather.trash_2,
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
    final DetailsBloc detailsBloc = Provider.of<DetailsBloc>(context);

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
          'Meu carrinho',
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
              child: detailsBloc.amountItemsOnCart == 0
                  ? Center(
                      child: Text(
                        'Carrinho vazio',
                        style: TextStyle(
                          color: colorBlueGray,
                          fontSize: 20.0,
                        ),
                      ),
                    )
                  : _renderProductsOnCart(context),
            ),
          ),
          Container(
            height: 100.0,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: colorWhite,
              boxShadow: [
                BoxShadow(
                  color: colorBlueGray.withAlpha(100),
                  blurRadius: 10.0,
                  offset: Offset(0.0, -5.0),
                  // spreadRadius: 5.0,
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  detailsBloc.amountItemsOnCart == 0
                      ? 'R\$ 0,00'
                      : detailsBloc.calcTotalPriceOfCart,
                  style: TextStyle(
                    color: colorBlack,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 60.0,
                  width: 200.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: RaisedButton(
                      onPressed: () {},
                      color: colorBrown,
                      highlightColor: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            AntDesign.creditcard,
                            color: colorWhite,
                            size: 25.0,
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            'Concluir',
                            style: TextStyle(
                              color: colorWhite,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
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
        ],
      ),
      backgroundColor: colorWhite,
    );
  }
}
