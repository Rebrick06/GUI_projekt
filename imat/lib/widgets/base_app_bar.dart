import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/shopping_cart.dart';
import 'package:imat_app/widgets/shopping_panel.dart' hide ShoppingCart;

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.mainColor,
      title: Text("IMats produkter för faan", style: AppTheme.titleFont),
      actions: [
<<<<<<< Updated upstream
        ActionChip(
          label: Text(
            "Shopping cart", 
            style: TextStyle(color: AppTheme.whiteColor), 
          ),
          labelStyle: AppTheme.textFont,
          backgroundColor: AppTheme.darkColor,
          onPressed: () {
            runApp(
              MaterialApp(
                home: MainCheckout()
              )
            );
          },
=======
        TextButton(
          onPressed: () {},
          child: Text("DETTA ÄR EN KASSA (trust)", style: AppTheme.textFont),
>>>>>>> Stashed changes
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}}
}
