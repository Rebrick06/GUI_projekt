import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/pages/main_checkout.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
  const BaseAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.mainColor,
      title: Text("IMats produkter för faan", style: AppTheme.titleFont,),
      
      actions: [
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
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}