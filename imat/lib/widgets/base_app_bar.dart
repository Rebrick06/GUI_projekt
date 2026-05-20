import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
  const BaseAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.mainColor,
      title: Text("IMats produkter för faan", style: AppTheme.titleFont),
      actions: [
        TextButton(
          onPressed: () {}, 
          child: Text(
            "DETTA ÄR EN KASSA (trust)",
            style: AppTheme.textFont,
          ),
        ),
      ]
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}