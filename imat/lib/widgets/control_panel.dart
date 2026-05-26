import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/widgets/filter_control.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key}); 

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.radius * (5/3)),
      child: Container(
        padding: EdgeInsets.all(20),
        color: AppTheme.brightColor,
        child: FilterControl()
      )
    );
  } 
}