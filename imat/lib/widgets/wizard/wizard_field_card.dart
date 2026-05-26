import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/wizard_field.dart';

class WizardFieldCard extends StatelessWidget {
  final WizardField step;
  final List<TextEditingController> controllers;
  final int startIndex;

  const WizardFieldCard({
    super.key,
    required this.step,
    required this.controllers,
    required this.startIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          // Påverkar titel
          padding: EdgeInsetsGeometry.only(top: AppTheme.paddingMedium),
          child: Text(
            step.label,
            style: AppTheme.textFont.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
        ),
        const SizedBox(height: AppTheme.paddingSmall,),

        Column(
          children: List.generate(step.fields.length, (index) { 
            final field = step.fields[index];
            final controller = controllers[startIndex + index];

            return Padding( // För framtida storleks skjusteringar. 
              //Påverkar basic inmatningsfälten 
              padding: EdgeInsets.only(bottom: 0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // För special fallen //
                  if (field.title != null)
                  Padding(
                    // Påverkar titel
                    padding: const EdgeInsets.only(
                      top: AppTheme.paddingMedium,
                      bottom: AppTheme.paddingSmall
                    ),

                    child: Text(
                      field.title!,
                      style: AppTheme.textFont.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ),

                  // For the commoners // 
                  TextField(
                    controller: controller,
                    obscureText: field.obscure,
                    autofocus: true,

                    style: AppTheme.textFont.copyWith(
                      fontSize: 24,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),

                    decoration: InputDecoration(
                      hintText: field.hint,

                      prefixIcon: Icon(
                        field.icon,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),

                      filled: true,
                      fillColor: AppTheme.whiteColor,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radius,),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),              
            );
          }),
        ),
      ],
    );
  }
}