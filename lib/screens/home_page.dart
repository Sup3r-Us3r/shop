import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shop/constants/colors.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/screens/categories.dart';
import 'package:shop/screens/details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String imageUrl =
      'https://avatars0.githubusercontent.com/u/22561893?s=460&u=fcc8d1cf270f6eb3c101fcd56021713a379c43a9&v=4';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Categories(),
                            ),
                          );
                        },
                        icon: Icon(
                          Ionicons.ios_options,
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
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'The most popular clothes today',
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
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      AntDesign.search1,
                      color: colorDarkGray,
                      size: 25.0,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: colorBrown,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Search...',
                        fillColor: Colors.red,
                        focusColor: Colors.blue,
                        hintStyle: TextStyle(
                          color: colorDarkGray,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 30.0,
                mainAxisSpacing: 40.0,
                itemCount: productsList.length,
                itemBuilder: (BuildContext context, int index) {
                  ProductsModel post = productsList[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(product: post),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Hero(
                            tag: post.imageUrl,
                            child: Image.network(
                              post.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
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
                                post.name,
                                style: TextStyle(
                                  color: colorBlack,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                post.price,
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
            ),
          ],
        ),
      ),
      backgroundColor: colorWhite,
    );
  }
}
