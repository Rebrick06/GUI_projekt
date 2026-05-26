import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/customer.dart';
import 'package:imat_app/pages/delivery_time.dart';
import 'package:imat_app/widgets/base_app_bar.dart';
import 'package:imat_app/widgets/base_footer.dart';

class DeliveryInfoPage extends StatefulWidget {
  const DeliveryInfoPage({super.key});

  @override
  State<DeliveryInfoPage> createState() => _DeliveryInfoPageState();
}

class _DeliveryInfoPageState extends State<DeliveryInfoPage> {
  int _currentStep = 0;

  final List<TextEditingController> _controllers =
      List.generate(8, (_) => TextEditingController());

  final List<Map<String, String>> _fields = const [
    {'label': 'Förnamn',            'hint': 'Skriv ditt förnamn här'},
    {'label': 'Efternamn',          'hint': 'Skriv ditt efternamn här'},
    {'label': 'Telefonnummer',      'hint': 'Skriv ditt telefonnummer här'},
    {'label': 'Mobiltelefonnummer', 'hint': 'Skriv ditt mobiltelefonnummer här'},
    {'label': 'Email',              'hint': 'Skriv din email här'},
    {'label': 'Adress',             'hint': 'Skriv din adress här'},
    {'label': 'Postkod',            'hint': 'Skriv din postkod här'},
    {'label': 'Postadress',         'hint': 'Skriv din postadress här'},
  ];

  bool get _isLastStep => _currentStep == _fields.length - 1;

  void _next() {
    if (_isLastStep) {
      final customer = Customer(
        _controllers[0].text,
        _controllers[1].text,
        _controllers[2].text,
        _controllers[3].text,
        _controllers[4].text,
        _controllers[5].text,
        _controllers[6].text,
        _controllers[7].text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SelectDeliveryTimePage(),
          ),
        );
    } else {
      setState(() => _currentStep++);
    }
  }

  void _previous() {
    if (_currentStep > 0) setState(() => _currentStep--);
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(),
      backgroundColor: AppTheme.whiteColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.paddingMedium),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.brightColor,
                  borderRadius: BorderRadius.circular(AppTheme.radius),
                ),
                padding: const EdgeInsets.all(AppTheme.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Leveransuppgifter',
                      style: AppTheme.titleFont.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkColor,
                      ),
                    ),
                    const SizedBox(height: AppTheme.paddingMedium),

                    // ── Stegindikator ──
                    _StepIndicator(
                      total: _fields.length,
                      current: _currentStep,
                    ),
                    const SizedBox(height: AppTheme.paddingLarge),

                    // ── Aktivt fält ──
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, animation) => SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.15, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(opacity: animation, child: child),
                        ),
                        child: _FieldCard(
                          key: ValueKey(_currentStep),
                          label: _fields[_currentStep]['label']!,
                          hint: _fields[_currentStep]['hint']!,
                          controller: _controllers[_currentStep],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppTheme.paddingLarge),

                    // ── Navigeringsknappar ──
                    Row(
                      children: [
                        if (_currentStep > 0)
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppTheme.darkColor,
                                side: BorderSide(color: AppTheme.darkColor),
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppTheme.paddingMedium,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppTheme.radius),
                                ),
                              ),
                              onPressed: _previous,
                              child: Text(
                                'Tillbaka',
                                style: AppTheme.textFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkColor,
                                ),
                              ),
                            ),
                          ),
                        if (_currentStep > 0)
                          const SizedBox(width: AppTheme.paddingSmall),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.darkColor,
                              foregroundColor: AppTheme.whiteColor,
                              padding: const EdgeInsets.symmetric(
                                vertical: AppTheme.paddingMedium,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppTheme.radius),
                              ),
                            ),
                            onPressed: _next,
                            child: Text(
                              _isLastStep ? 'Fortsätt till leveranstid' : 'Nästa →',
                              style: AppTheme.textFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const BaseFooter(),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int total;
  final int current;

  const _StepIndicator({required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (index) {
        final isActive = index == current;
        final isDone = index < current;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < total - 1 ? 4 : 0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 6,
              decoration: BoxDecoration(
                color: isDone || isActive
                    ? AppTheme.darkColor
                    : AppTheme.whiteColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _FieldCard extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const _FieldCard({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppTheme.textFont.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkColor,
          ),
        ),
        const SizedBox(height: AppTheme.paddingSmall),
        Material(
          color: Colors.transparent,
          child: TextField(
            controller: controller,
            autofocus: true,
            style: AppTheme.textFont.copyWith(
              fontSize: 15,
              color: AppTheme.darkColor,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTheme.textFont.copyWith(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              filled: true,
              fillColor: AppTheme.whiteColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppTheme.paddingMedium,
                vertical: AppTheme.paddingMediumSmall,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radius),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
