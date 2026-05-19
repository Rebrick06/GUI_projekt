import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget{
  const BaseAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.mainColor,
      title: Text("hehe test title placholder hehe michael jackson he he"),
      actions: [
        TextButton(
          onPressed: () {}, 
          child: Text(
            "IMats produkter för faan",
            style: AppTheme.titleFont
          ),
        ),
      ]
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}