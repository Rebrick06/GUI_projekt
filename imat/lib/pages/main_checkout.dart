import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/shopping_item.dart';
import 'package:imat_app/model/imat_data_handler.dart';

import 'package:imat_app/pages/delivery_information.dart';
import 'package:imat_app/widgets/base_app_bar.dart';
import 'package:imat_app/widgets/base_footer.dart';

class MainCheckout extends StatelessWidget {
  const MainCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();
    final items = iMat.getShoppingCart().items;

    // ---- SUMMERINGAR ----
    final int itemCount =
        items.fold<int>(0, (sum, it) => sum + it.amount.toInt());
    final double subtotal = items.fold<double>(
      0.0,
      (sum, it) => sum + it.product.price * it.amount,
    );

    const double boxFee = 0.0; 
    const double vatRate = 0.0; 
    final double vat = subtotal * vatRate;
    final double total = subtotal + boxFee + vat;

    // ---- GRUPPERA PER KATEGORI ----
    final Map<String, List<ShoppingItem>> grouped = {};
    for (final it in items) {
      final String raw =
          (it.product.category ?? '').toString().trim(); 
      final String key = raw.isEmpty ? 'Övrigt' : raw;
      grouped.putIfAbsent(key, () => []).add(it);
    }

    // Önskad ordning på kategorier
    final List<String> preferredOrder = [
      'Favoriter',
      'Kött & Fisk',
      'KÖTT',
      'FISK',
      'MEJERI',
      'GRÖNSAKER',
      'SKAFFERI',
      'BASVAROR',
      'BRÖD',
      'FRUKT',
      'DRYCK',
      'SNACKS',
      'Övrigt',
      'MEAT', 
      'FISH',
      'FLOUR_SUGAR_SALT',
    ];

    List<String> sortedCategories = grouped.keys.toList();
    sortedCategories.sort((a, b) {
      int pos(String x) => preferredOrder.indexOf(x);
      final ia = pos(a);
      final ib = pos(b);
      if (ia != -1 && ib != -1) return ia.compareTo(ib);
      if (ia != -1) return -1;
      if (ib != -1) return 1;
      return a.toLowerCase().compareTo(b.toLowerCase());
    });

    return Scaffold(
      appBar: const BaseAppBar(),
      backgroundColor: AppTheme.whiteColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ------- VÄNSTERKOLUMN: GRUPPERADE VAROR -------
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

                        if (items.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Text(
                              'Varukorgen är tom',
                              style: AppTheme.textFont.copyWith(
                                color: Colors.black45,
                                fontSize: 18,
                              ),
                            ),
                          )
                        else
                          ...sortedCategories.expand((categoryRaw) sync* {
                            final catItems = grouped[categoryRaw]!;
      
                            yield Padding(
                              padding: const EdgeInsets.only(top: 24, bottom: 12),
                              child: Text(
                                prettyCategory(categoryRaw),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                            // Kategori-items
                            for (final item in catItems) {
                              final lineTotal =
                                  item.product.price * item.amount.toDouble();
                              yield Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(AppTheme.radius),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(AppTheme.paddingSmall),
                                child: Row(
                                  children: [
                                    // Bild
                                    SizedBox(
                                      width: 56,
                                      height: 56,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: iMat.getImage(item.product),
                                      ),
                                    ),
                                    const SizedBox(width: AppTheme.paddingSmall),

                                    // Namn + pris/enhet
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.product.name,
                                            style: AppTheme.textFont.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            '${item.product.price.toStringAsFixed(2)} kr/${item.product.unit}',
                                            style: AppTheme.textFont.copyWith(
                                              color: Colors.black54,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Antal +/− och radbelopp
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            _StepButton(
                                              icon: Icons.remove,
                                              onTap: () {
                                                if (item.amount > 1) {
                                                  item.amount--;
                                                  iMat.notifyListeners();
                                                } else {
                                                  iMat.shoppingCartRemove(item);
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              width: 36,
                                              child: Center(
                                                child: Text(
                                                  item.amount.toInt().toString(),
                                                  style: AppTheme.textFont.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            _StepButton(
                                              icon: Icons.add,
                                              onTap: () => iMat
                                                  .shoppingCartAdd(ShoppingItem(item.product)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          '${lineTotal.toStringAsFixed(2)} kr',
                                          style: AppTheme.textFont.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                          }),

                        const SizedBox(height: 40),

                        // Töm varukorgen
                        Center(
                          child: SizedBox(
                            width: 300,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.darkColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: items.isEmpty
                                  ? null
                                  : () {
                                      for (final it in List.of(items)) {
                                        iMat.shoppingCartRemove(it);
                                      }
                                    },
                              child: const Text(
                                'Töm varukorgen',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
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

                  // ------- HÖGERKOLUMN: SUMMERING -------
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.brightColor,
                        borderRadius: BorderRadius.circular(18),
                        //border: Border.all(color: AppTheme.mainColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('$itemCount varor', style: const TextStyle(fontSize: 18)),
                              Text('${subtotal.toStringAsFixed(2)} kr',
                                  style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Delsumma',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${subtotal.toStringAsFixed(2)} kr',
                              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(height: 40),

                          if (boxFee > 0) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('lådor', style: TextStyle(fontSize: 20)),
                                Text('${boxFee.toStringAsFixed(2)} kr',
                                    style: const TextStyle(fontSize: 20)),
                              ],
                            ),
                            const Divider(height: 40),
                          ],

                          if (vat > 0) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Moms', style: TextStyle(fontSize: 20)),
                                Text('${vat.toStringAsFixed(2)} kr',
                                    style: const TextStyle(fontSize: 20)),
                              ],
                            ),
                            const Divider(height: 40),
                          ],

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Totalt inkl.\nmoms',
                                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${total.toStringAsFixed(2)} kr',
                                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          const Spacer(),
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
                              onPressed: items.isEmpty
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const DeliveryInfoPage(),
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

          const BaseFooter(),
        ],
      ),
    );
  }
}

// ------------ Hjälpfunktion för kategorinamn ------------
String prettyCategory(String raw) {
  // 1) Ta bort prefixet
  String key = raw;
  const prefix = 'ProductCategory.';
  if (key.startsWith(prefix)) {
    key = key.substring(prefix.length);
  }

  // 2) Specialkartläggning för snygga svenska namn
  const Map<String, String> special = {
    'MEAT': 'Kött',
    'FISH': 'Fisk',
    'FLOUR_SUGAR_SALT': 'Mjöl, socker & salt',
    'DAIRY': 'Mejeri',
    'VEGETABLES': 'Grönsaker',
    'PANTRY': 'Skafferi',
    'BASICS': 'Basvaror',
  };
  if (special.containsKey(key)) return special[key]!;

  final spaced = key.replaceAll('_', ' ').trim();
  if (spaced.isEmpty) return 'Övrigt';

  // Titel-fall enkelt: Första bokstaven stor, resten små
  return spaced[0].toUpperCase() + spaced.substring(1).toLowerCase();
}

// ------- Återanvändbar step-knapp -------
class _StepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _StepButton({required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 24,
        decoration: BoxDecoration(
          color: AppTheme.darkColor,
          borderRadius: BorderRadius.circular(AppTheme.paddingTiny),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: AppTheme.whiteColor, size: 16),
      ),
    );
  }
}
