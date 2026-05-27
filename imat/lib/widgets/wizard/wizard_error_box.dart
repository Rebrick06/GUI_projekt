import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';

class WizardErrorBox extends StatelessWidget {
  final String message;
  const WizardErrorBox({super.key, required this.message,});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppTheme.paddingMedium,),
      padding: const EdgeInsets.all(AppTheme.paddingMedium),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 0, 0),
        borderRadius: BorderRadius.circular(AppTheme.radius),
      ),

      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTheme.textFont.copyWith(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}