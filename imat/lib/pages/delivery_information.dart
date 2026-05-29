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
  int _step = 0;
  // Controllers
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final postCodeCtrl = TextEditingController();
  final postCityCtrl = TextEditingController();
  // Valideringsnycklar per steg
  final _formKeys = List.generate(3, (_) => GlobalKey<FormState>());
  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    mobileCtrl.dispose();
    addressCtrl.dispose();
    postCodeCtrl.dispose();
    postCityCtrl.dispose();
    super.dispose();
  }
  void _next() {
    final form = _formKeys[_step].currentState!;
    if (!form.validate()) return;
    if (_step < 2) {
      setState(() => _step++);
    } else {
      final customer = Customer(
        firstNameCtrl.text.trim(),
        lastNameCtrl.text.trim(),
        phoneCtrl.text.trim(),
        mobileCtrl.text.trim(),
        emailCtrl.text.trim(),
        addressCtrl.text.trim(),
        postCodeCtrl.text.trim(),
        postCityCtrl.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectDeliveryTimePage(customer: customer),
        ),
      );
    }
  }
  void _back() {
    if (_step > 0) setState(() => _step--);
  }
  @override
  Widget build(BuildContext context) {
    // Responsiv maxbredd
    final screenW = MediaQuery.of(context).size.width;
    final maxW = screenW >= 1000 ? 760.0 : 560.0;
    return Scaffold(
      appBar: const BaseAppBar(),
      backgroundColor: AppTheme.whiteColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.paddingMedium),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxW),
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
                        _CompactStepBar(current: _step, total: 3),
                        const SizedBox(height: AppTheme.paddingMedium),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: _buildStep(_step),
                          ),
                        ),
                        const SizedBox(height: AppTheme.paddingMedium),
                        Row(
                          children: [
                            if (_step > 0)
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
                                  onPressed: _back,
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
                            if (_step > 0)
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
                                  _step == 2
                                      ? 'Fortsätt till leveranstid'
                                      : 'Nästa →',
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
            ),
          ),
          const BaseFooter(),
        ],
      ),
    );
  }
  // Slides
  Widget _buildStep(int step) {
    switch (step) {
      case 0:
        return Form(
          key: _formKeys[0],
          child: _FieldGroup(
            children: [
              _TextField(
                label: 'Förnamn',
                hint: 'Skriv ditt förnamn här',
                controller: firstNameCtrl,
                validator: _req,
              ),
              _TextField(
                label: 'Efternamn',
                hint: 'Skriv ditt efternamn här',
                controller: lastNameCtrl,
                validator: _req,
              ),
              _TextField(
                label: 'E‑post*',
                hint: 'Skriv din e‑post här',
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: _email,
              ),
            ],
          ),
        );
      case 1:
        return Form(
          key: _formKeys[1],
          child: _FieldGroup(
            children: [
              _TextField(
                label: 'Telefonnummer',
                hint: 'Skriv ditt telefonnummer här',
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                validator: _req,
              ),
              _TextField(
                label: 'Mobiltelefonnummer',
                hint: 'Skriv ditt mobiltelefonnummer här',
                controller: mobileCtrl,
                keyboardType: TextInputType.phone,
                validator: _req,
              ),
            ],
          ),
        );
      case 2:
      default:
        return Form(
          key: _formKeys[2],
          child: _FieldGroup(
            children: [
              _TextField(
                label: 'Adress',
                hint: 'Skriv din adress här',
                controller: addressCtrl,
                validator: _req,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _TextField(
                      label: 'Postkod',
                      hint: 'Ex. 123 45',
                      controller: postCodeCtrl,
                      keyboardType: TextInputType.number,
                      validator: _req,
                    ),
                  ),
                  const SizedBox(width: AppTheme.paddingSmall),
                  Expanded(
                    flex: 2,
                    child: _TextField(
                      label: 'Postort',
                      hint: 'Skriv din postort här',
                      controller: postCityCtrl,
                      validator: _req,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
    }
  }
  // Validering
  String? _req(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Detta fält är obligatoriskt' : null;
  String? _email(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Detta fält är obligatoriskt';
    final ok = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(s);
    return ok ? null : 'Ogiltig e‑postadress';
  }
}
// Kompakt stegbar
class _CompactStepBar extends StatelessWidget {
  final int current;
  final int total;
  const _CompactStepBar({required this.current, required this.total});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        final active = i <= current;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < total - 1 ? 6 : 0),
            height: 6,
            decoration: BoxDecoration(
              color: active ? AppTheme.darkColor : AppTheme.whiteColor,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }),
    );
  }
}
// Layoutcontainer för jämn spacing
class _FieldGroup extends StatelessWidget {
  final List<Widget> children;
  const _FieldGroup({required this.children});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: ValueKey(children.length),
      padding: EdgeInsets.zero,
      itemCount: children.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppTheme.paddingSmall),
      itemBuilder: (_, i) => children[i],
    );
  }
}
class _TextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const _TextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.textFont.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkColor,
          ),
        ),
        const SizedBox(height: AppTheme.paddingTiny),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
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
      ],
    );
  }
}