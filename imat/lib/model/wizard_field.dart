import 'package:flutter/material.dart';

class WizardField {
  final String label;
  final List<FieldData> fields;
  final String? Function(List<TextEditingController>)? validator;

  const WizardField({
    required this.label,
    required this.fields,
    this.validator,
  });
}

class FieldData {
  final String hint;
  final IconData icon;
  final bool obscure;
  final String? title;

  const FieldData({
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.title,
  });
}
