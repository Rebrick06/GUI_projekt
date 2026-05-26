import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/wizard_field.dart';
import 'package:imat_app/widgets/base_footer.dart';
import 'package:imat_app/widgets/wizard/wizard_error_box.dart';
import 'package:imat_app/widgets/wizard/wizard_field_card.dart';
import 'package:imat_app/widgets/wizard/wizard_navigation_buttons.dart';
import 'package:imat_app/widgets/wizard/wizard_step_indicator.dart';

class BaseWizardPage extends StatefulWidget {
  const BaseWizardPage({
    super.key,
    required this.title,
    required this.currentStep,
    required this.fields,
    required this.controllers,
    required this.onNext,
    required this.onBack,
    required this.finishText,
  });

  final String title;
  final int currentStep;
  final List<WizardField> fields;
  final List<TextEditingController> controllers;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final String finishText;

  @override
  State<BaseWizardPage> createState() => _BaseWizardPageState();
}

class _BaseWizardPageState extends State<BaseWizardPage> {

  String? errorMessage;

  void validateCurrentStep() {
    final field = widget.fields[widget.currentStep];

    int startIndex = 0;

    for (int i = 0; i < widget.currentStep; i++) {
      startIndex += widget.fields[i].fields.length;
    }

    final stepControllers = widget.controllers.sublist(
      startIndex,
      startIndex + field.fields.length,
    );
    // När special valdiation behövs
    if (field.validator != null) {
      final error = field.validator!(stepControllers);

      if (error != null) {
        setState(() {
          errorMessage = error;
        });
        return;
      }
    } else {
      // Standard tomfält-validering
      final hasEmptyField =
          stepControllers.any((c) => c.text.trim().isEmpty);

      if (hasEmptyField) {
        setState(() {
          errorMessage =
              '${field.label} måste fyllas i';
        });
        return;
      }
    }

    setState(() {
      errorMessage = null;
    });

    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final field = widget.fields[widget.currentStep];

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.paddingMedium),
            child: Container(
              padding: const EdgeInsets.all(AppTheme.paddingLarge),
              decoration: BoxDecoration(
                color: AppTheme.brightColor,
                borderRadius: BorderRadius.circular(AppTheme.radius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title),

                  WizardStepIndicator(
                    total: widget.fields.length,
                    current: widget.currentStep,
                  ),

                  if (errorMessage != null)
                    WizardErrorBox(message: errorMessage!),

                  Expanded(
                    child: Builder(
                      builder: (context) {
                        int startIndex = 0;

                        for (int i = 0; i < widget.currentStep; i++) {
                          startIndex += widget.fields[i].fields.length;
                        }

                        return WizardFieldCard(
                          step: field,
                          controllers: widget.controllers,
                          startIndex: startIndex,
                        );
                      },
                    ),
                  ),

                  WizardNavigationButtons(
                    showBack: widget.currentStep > 0,
                    isLastStep: widget.currentStep == widget.fields.length - 1,
                    onNext: validateCurrentStep,
                    onBack: widget.onBack,
                    finishText: widget.finishText,
                  ),
                ],
              ),
            ),
          ),
        ),
        const BaseFooter(),
      ],
    );
  }

}
