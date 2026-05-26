import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';

class WizardNavigationButtons extends StatelessWidget {
  final bool showBack;
  final bool isLastStep;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final String finishText;

  const WizardNavigationButtons({
    super.key,
    required this.showBack,
    required this.isLastStep,
    required this.onNext,
    required this.onBack,
    required this.finishText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBack)
          Expanded(
            child: OutlinedButton(
              onPressed: onBack,

              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.darkColor,
                side: BorderSide(color: AppTheme.darkColor,),

                padding: const EdgeInsets.symmetric(
                  vertical: AppTheme.paddingMedium,
                ),
                shape: RoundedRectangleBorder( 
                  borderRadius: BorderRadius.circular(AppTheme.radius,),
                ),
              ),

              child: Text(
                'Tillbaka',

                style: AppTheme.textFont.copyWith(
                  fontSize: 24,
                  color: AppTheme.darkColor,
                ),
              ),
            ),
          ),

        if (showBack)
          const SizedBox(width: AppTheme.paddingSmall,),
        Expanded(
          child: ElevatedButton(
            onPressed: onNext,

            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.darkColor,
              foregroundColor: AppTheme.whiteColor,

              padding: const EdgeInsets.symmetric(
                vertical: AppTheme.paddingMedium,
              ),

              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(AppTheme.radius,),
              ),
            ),

            child: Text(
              isLastStep? finishText: 'Nästa',
              style: AppTheme.textFont.copyWith(
                fontSize: 24,
                color: AppTheme.whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}