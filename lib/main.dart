import 'package:flutter/material.dart';
import 'package:shop/blocs/details_bloc.dart';
import 'package:shop/route_generator.dart';
import 'package:shop/screens/home_page.dart';
import 'constants/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DetailsBloc>.value(
          value: DetailsBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop',
        home: HomePage(),
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          primaryColor: colorWhite,
          accentColor: colorBrown,
          appBarTheme: AppBarTheme(
            elevation: 0.0,
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.routeGenerator,
      ),
    ),
  );
}
