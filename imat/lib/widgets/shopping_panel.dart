import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/shopping_item.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/pages/main_checkout.dart';
import 'package:provider/provider.dart';

class ShoppingPanel extends StatelessWidget {
  final ImatDataHandler iMat;
  final double width;

  const ShoppingPanel(this.width, this.iMat, {super.key});

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();
    final items = iMat.getShoppingCart().items;

    final double total = items.fold(
      0,
      (sum, item) => sum + item.product.price * item.amount,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.radius),
      child: Container(
        width: width,
        color: AppTheme.brightColor,
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.paddingMediumSmall,
                vertical: AppTheme.paddingSmall,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Varukorg',
                    style: AppTheme.titleFont.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      for (final item in List.of(items)) {
                        iMat.shoppingCartRemove(item);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.darkColor,
                        borderRadius: BorderRadius.circular(
                          AppTheme.paddingSmall,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Töm varukorg',
                            style: AppTheme.textFont.copyWith(
                              color: AppTheme.whiteColor,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(width: AppTheme.paddingTiny),
                          Icon(
                            Icons.delete_outline,
                            color: AppTheme.whiteColor,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Item list ────────────────────────────────────────
            Expanded(
              child:
                  items.isEmpty
                      ? Center(
                        child: Text(
                          'Varukorgen är tom',
                          style: AppTheme.textFont.copyWith(
                            color: Colors.black45,
                            fontSize: 16,
                          ),
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.all(AppTheme.paddingSmall),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: AppTheme.paddingSmall,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                AppTheme.radius,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(
                              AppTheme.paddingSmall,
                            ),
                            child: Row(
                              children: [
                                // Product image
                                SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: iMat.getImage(item.product),
                                  ),
                                ),
                                const SizedBox(width: AppTheme.paddingSmall),

                                // Name + price
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product.name,
                                        style: AppTheme.textFont.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
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

                                // +/qty/- stepper
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _StepButton(
                                      icon: Icons.add,
                                      onTap:
                                          () => iMat.shoppingCartAdd(
                                            ShoppingItem(item.product),
                                          ),
                                    ),
                                    SizedBox(
                                      width: 28,
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
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),

            // ── Footer ───────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.paddingMediumSmall,
                vertical: AppTheme.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: AppTheme.brightColor,
                border: Border(
                  top: BorderSide(
                    color: AppTheme.mainColor.withOpacity(0.4),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Totalt:',
                        style: AppTheme.textFont.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        '${total.toStringAsFixed(2)} kr',
                        style: AppTheme.textFont.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.paddingSmall),
                  ElevatedButton(
                    onPressed:
                        items.isEmpty
                            ? null
                            : () {
                                Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => MainCheckout()),
                              );
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.darkColor,
                      foregroundColor: AppTheme.whiteColor,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppTheme.paddingSmall,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radius),
                      ),
                      elevation: 0,
                      textStyle: AppTheme.textFont.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    child: const Text('Gå till kassan'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable stepper button ──────────────────────────────────────────────────

class _StepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _StepButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 22,
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
