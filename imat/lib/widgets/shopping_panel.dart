import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart';

class ShoppingPanel extends StatelessWidget {
  final ImatDataHandler iMat;
  final double width;

  const ShoppingPanel(this.width, this.iMat, {super.key});

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.radius),
      child: Container(
        padding: EdgeInsets.all(20),
        width: width,
        color: AppTheme.brightColor,
        child: Column(
          children: [
            for (var item in iMat.getShoppingCart().items) 
              Row(
                children: [
                  Text(item.product.name ),
                  SizedBox(width: 4),
                  Text(item.amount.toString()),
                  TextButton(
                    onPressed: (){
                      iMat.shoppingCartRemove(item);
                    },
                    child: Text("Remove"),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
