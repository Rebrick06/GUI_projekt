import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/widgets/add_to_cart_buton.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ImatDataHandler iMat;
  final VoidCallback? onTap;

  const ProductCard(this.product, this.iMat, {super.key, this.onTap});

  @override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.paddingSmall),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: iMat.getImage(product),
                    ),
                  ),

                  Text(
                    product.name,
                    textAlign: TextAlign.center,
                    style: AppTheme.textFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: AppTheme.paddingSmall),

                  Text(
                    '${product.price.toStringAsFixed(2)} ${product.unit}',
                    style: AppTheme.textFont.copyWith(
                      fontSize: 14,
                    ),
                  ),

                  AddToCartButon(product, iMat),
                ],
              ),
            ),
          ),

          Positioned(
            top: 2,
            right: 2,
            child: IconButton(
              onPressed: () {
                iMat.toggleFavorite(product);
              },
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(4),
              icon: Icon(iMat.isFavorite(product)
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.amber,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}