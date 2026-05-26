import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';

class ImatBackButton extends StatelessWidget {
  const ImatBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.of(context).pop(),
      backgroundColor: AppTheme.darkColor,
      icon: const Icon(Icons.arrow_back, color: Colors.white),
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
