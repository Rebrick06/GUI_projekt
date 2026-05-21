import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat/shopping_item.dart';
import 'package:imat_app/model/imat_data_handler.dart';

class AddToCartButon extends StatelessWidget {
  final Product product;
  final ImatDataHandler iMat;

  const AddToCartButon(this.product, this.iMat, {super.key});

  ShoppingItem get item => ShoppingItem(product);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(
        'Lägg i varukorg',
        style: TextStyle(color: AppTheme.whiteColor),
      ),

      labelStyle: AppTheme.textFont,
      backgroundColor: AppTheme.darkColor,
      onPressed: () {
        iMat.shoppingCartAdd(item);
      },
    );
  }
}
