import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat/shopping_cart.dart';
import 'package:imat_app/model/imat_data_handler.dart';

class ShoppingPanel extends StatelessWidget {
  final ImatDataHandler iMat;
  final double width;

  const ShoppingPanel(this.width, this.iMat, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(20),
        width: width,
        color: AppTheme.brightColor,
        child: Column(
          children: [/*print(iMat.getShoppingCart())*/ Placeholder()],
        ),
      ),
    );
  }
}
