import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';

class WizardStepIndicator extends StatelessWidget {
  final int total;
  final int current;

  const WizardStepIndicator(
      {
        super.key,
        required this.total,
        required this.current,
      }
    );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (index) {
        final active = index <= current;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index < total - 1 ? 4 : 0,
            ),
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: active ? AppTheme.darkColor: AppTheme.whiteColor,
                borderRadius: BorderRadius.circular(AppTheme.radius),
              ),
            ),
          ),
        );
      }),
    );
  }
}