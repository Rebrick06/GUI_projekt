import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/pages/delivery_information.dart';
import 'package:imat_app/pages/delivery_time.dart';
import 'package:imat_app/widgets/base_app_bar.dart';
import 'package:imat_app/widgets/base_footer.dart';

class MainCheckout extends StatelessWidget {
  const MainCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(),
      backgroundColor: const Color(0xFFEFEFEF),

      body: Column(
        children: [
          // MAIN CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LEFT COLUMN
                  Expanded(
                    flex: 3,
                    child: ListView(
                      children: [
                        const Text(
                          'Varukorg',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Kolla igenom din varukorg innan du slutför ditt köp',
                          style: TextStyle(fontSize: 20),
                        ),

                        const SizedBox(height: 16),

                        // TODO:
                        // CartItemCard här
                        const SizedBox(height: 32),

                        const Text(
                          'Kött',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Cart item här
                        const SizedBox(height: 32),

                        const Text(
                          'Skafferi',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Cart item här
                        const SizedBox(height: 60),

                        Center(
                          child: SizedBox(
                            width: 300,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Töm varukorgen',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 60),
                      ],
                    ),
                  ),

                  const SizedBox(width: 32),

                  // RIGHT COLUMN
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.grey.shade400),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('25 varor', style: TextStyle(fontSize: 18)),
                              Text('157,55 kr', style: TextStyle(fontSize: 18)),
                            ],
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Delsumma',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '803,2 kr',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const Divider(height: 40),

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('lådor', style: TextStyle(fontSize: 20)),
                              Text('9,00 kr', style: TextStyle(fontSize: 20)),
                            ],
                          ),

                          const Divider(height: 40),

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Totalt inkl.\nmoms',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '190,55 kr',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.darkColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const DeliveryInfoPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Fortsätt →',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // FOOTER
          const BaseFooter(),
        ],
      ),
    );
  }
}
