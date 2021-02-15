import 'package:flutter/material.dart';
import 'package:shop/constants/colors.dart';

class ButtonAction extends StatelessWidget {
  final String label;
  final bool redirectsToAnotherPage;

  ButtonAction({
    @required this.label,
    this.redirectsToAnotherPage = false,
  });

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 50.0,
      width: _sizeWidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: redirectsToAnotherPage ? colorBlueGray : colorBrown,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colorWhite,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
