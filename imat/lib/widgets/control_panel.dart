import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';

class ControlPanel extends StatelessWidget {
  final double width;

  const ControlPanel(this.width,{super.key}); 

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(20),
        width: width, 
        color: AppTheme.brightColor,
        child: Column(children: [
          Placeholder()
        ],)
      )
    );
  }
}