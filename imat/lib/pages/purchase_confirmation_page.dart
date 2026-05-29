import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/order.dart';
import 'package:imat_app/widgets/base_app_bar.dart';
import 'package:imat_app/widgets/base_footer.dart';

class ThankYouPage extends StatelessWidget {
  final Order order;

  const ThankYouPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(),
      backgroundColor: const Color(0xFFEFEFEF),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.brightColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.mainColor),
                ),
                width: 560,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Tack för ditt köp',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Här har du ditt ordernummer',
                      style: AppTheme.textFont.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '#${order.orderNumber}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Orderdatum: ${order.date.toLocal()}',
                      style: AppTheme.textFont.copyWith(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.darkColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Till startsidan eller ordersida
                          Navigator.popUntil(context, (r) => r.isFirst);
                        },
                        child: const Text(
                          'Till startsidan',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
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
