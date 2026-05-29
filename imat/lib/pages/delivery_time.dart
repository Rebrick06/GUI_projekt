import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/customer.dart';
import 'package:imat_app/pages/final_summary_page.dart'; // PaymentSummaryPage
import 'package:imat_app/widgets/base_app_bar.dart';
import 'package:imat_app/widgets/base_footer.dart';
class SelectDeliveryTimePage extends StatefulWidget {
  final Customer customer; // NYTT: ta emot kunddata
  const SelectDeliveryTimePage({super.key, required this.customer});
  @override
  State<SelectDeliveryTimePage> createState() => _SelectDeliveryTimePageState();
}
class _SelectDeliveryTimePageState extends State<SelectDeliveryTimePage> {
  (int, int)? _selected;
  final List<Map<String, dynamic>> _days = const [
    {'name': 'Tisdag', 'slots': [false, false, true, true]},
    {'name': 'Onsdag', 'slots': [true, true, true, true]},
    {'name': 'Torsdag', 'slots': [false, true, true, true]},
    {'name': 'Fredag', 'slots': [true, true, false, false]},
    {'name': 'Lördag', 'slots': [false, true, true, true]},
  ];
  final List<String> _slotLabels = const ['9-12', '12-15', '15-18', '18-21'];
  String? _selectedWindowAsText() {
    if (_selected == null) return null;
    final (dayIndex, slotIndex) = _selected!;
    final dayName = _days[dayIndex]['name'] as String;
    final slot = _slotLabels[slotIndex];
    return '$dayName, $slot';
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
                      'Välj leveranstid',
                      style: AppTheme.titleFont.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkColor,
                      ),
                    ),
                    const SizedBox(height: AppTheme.paddingMedium),
                    Expanded(
                      child: ListView.separated(
                        itemCount: _days.length,
                        separatorBuilder: (_, __) => const SizedBox(
                          height: AppTheme.paddingMediumSmall,
                        ),
                        itemBuilder: (context, dayIndex) {
                          final day = _days[dayIndex];
                          final slots = day['slots'] as List<bool>;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                day['name'] as String,
                                style: AppTheme.textFont.copyWith(
                                  fontSize: 15,
                                  color: AppTheme.darkColor,
                                ),
                              ),
                              const SizedBox(height: AppTheme.paddingSmall),
                              Row(
                                children: List.generate(slots.length, (slotIndex) {
                                  final available = slots[slotIndex];
                                  final isSelected = _selected == (dayIndex, slotIndex);
                                  return Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: slotIndex < slots.length - 1
                                            ? AppTheme.paddingSmall
                                            : 0,
                                      ),
                                      child: _TimeSlotTile(
                                        label: _slotLabels[slotIndex],
                                        available: available,
                                        selected: isSelected,
                                        onTap: available
                                            ? () => setState(() {
                                                  _selected = isSelected ? null : (dayIndex, slotIndex);
                                                })
                                            : null,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppTheme.paddingMedium),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.darkColor,
                          foregroundColor: AppTheme.whiteColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppTheme.paddingMedium,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.radius),
                          ),
                        ),
                        onPressed: () {
                          final window = _selectedWindowAsText();
                          // Tillåt navigation även om ingen tid är vald? Här kräver vi val.
                          if (window == null) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentSummaryPage(
                                customer: widget.customer,
                                deliveryWindow: window,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Till betalning',
                          style: AppTheme.textFont.copyWith(
                            fontSize: 16,
                            color: AppTheme.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
class _TimeSlotTile extends StatelessWidget {
  final String label;
  final bool available;
  final bool selected;
  final VoidCallback? onTap;
  const _TimeSlotTile({
    required this.label,
    required this.available,
    required this.selected,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    if (!available) {
      return Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.circular(AppTheme.radius),
        ),
        child: CustomPaint(painter: _DiagonalLinePainter()),
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 48,
        decoration: BoxDecoration(
          color: selected ? AppTheme.mainColor : AppTheme.whiteColor,
          borderRadius: BorderRadius.circular(AppTheme.radius),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTheme.textFont.copyWith(
            color: selected ? AppTheme.whiteColor : AppTheme.darkColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
class _DiagonalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}