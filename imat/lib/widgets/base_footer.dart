import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:imat_app/app_theme.dart';

class BaseFooter extends StatelessWidget {
  const BaseFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Footer(
      backgroundColor: AppTheme.mainColor,
      child: Container(
        color: AppTheme.mainColor,
        height: 10,
        width: double.infinity, 
      ),
    );
    
  }
}