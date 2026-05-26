import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';

class ImatBackButton extends StatelessWidget {
  final VoidCallback onBack;

  const ImatBackButton(this.onBack, {super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onBack,
      backgroundColor: AppTheme.darkColor,
      icon: Icon(Icons.arrow_back, color: AppTheme.whiteColor),
      label: Text(
        'Tillbaka',
        style: AppTheme.textFont.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
