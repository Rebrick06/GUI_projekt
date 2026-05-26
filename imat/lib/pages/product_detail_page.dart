import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/widgets/add_to_cart_buton.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final ImatDataHandler iMat;
  final VoidCallback onBack;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.iMat,
    required this.onBack,
  });

  String get _categoryName {
    switch (product.category) {
      case ProductCategory.POD:
        return 'Baljväxter';
      case ProductCategory.BREAD:
        return 'Bröd';
      case ProductCategory.BERRY:
        return 'Bär';
      case ProductCategory.CITRUS_FRUIT:
        return 'Citrusfrukter';
      case ProductCategory.HOT_DRINKS:
        return 'Varma drycker';
      case ProductCategory.COLD_DRINKS:
        return 'Kalla drycker';
      case ProductCategory.EXOTIC_FRUIT:
        return 'Exotiska frukter';
      case ProductCategory.FISH:
        return 'Fisk';
      case ProductCategory.VEGETABLE_FRUIT:
        return 'Grönsaker & Frukt';
      case ProductCategory.CABBAGE:
        return 'Kål';
      case ProductCategory.MEAT:
        return 'Kött';
      case ProductCategory.DAIRIES:
        return 'Mejeriprodukter';
      case ProductCategory.MELONS:
        return 'Meloner';
      case ProductCategory.FLOUR_SUGAR_SALT:
        return 'Mjöl, Socker & Salt';
      case ProductCategory.NUTS_AND_SEEDS:
        return 'Nötter & Frön';
      case ProductCategory.PASTA:
        return 'Pasta';
      case ProductCategory.POTATO_RICE:
        return 'Potatis & Ris';
      case ProductCategory.ROOT_VEGETABLE:
        return 'Rotfrukter';
      case ProductCategory.FRUIT:
        return 'Frukt';
      case ProductCategory.SWEET:
        return 'Godis';
      case ProductCategory.HERB:
        return 'Kryddor';
      case ProductCategory.UNDEFINED:
        return 'Övrigt';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── Scrollable content ──────────────────────────────────
        SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.paddingLarge),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Left column ─────────────────────────────────
              SizedBox(
                width: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(AppTheme.radius),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: iMat.getImage(product),
                    ),
                    const SizedBox(height: AppTheme.paddingMedium),
                    Text(
                      product.name,
                      style: AppTheme.titleFont.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppTheme.paddingSmall),
                    Text(
                      '${product.price.toStringAsFixed(2)} kr',
                      style: AppTheme.textFont.copyWith(fontSize: 20),
                    ),
                    Text(
                      'jämförelse pris ${product.price.toStringAsFixed(2)} ${product.unit}',
                      style: AppTheme.textFont.copyWith(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: AppTheme.paddingMedium),
                    AddToCartButon(product, iMat),
                  ],
                ),
              ),

              const SizedBox(width: AppTheme.paddingLarge),

              // ── Right column ─────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _InfoBox(title: 'Kategori', content: _categoryName),
                    const SizedBox(height: AppTheme.paddingSmall),
                    _InfoBox(
                      title: 'Pris',
                      content:
                          '${product.price.toStringAsFixed(2)} ${product.unit}',
                    ),
                    const SizedBox(height: AppTheme.paddingSmall),
                    _InfoBox(
                      title: 'Ekologisk',
                      content: product.isEcological ? 'Ja ✓' : 'Nej',
                    ),
                    const SizedBox(height: AppTheme.paddingSmall),
                    _InfoBox(
                      title: 'Artikelnummer',
                      content: product.productId.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ── Tillbaka button ─────────────────────────────────────
        Positioned(
          left: AppTheme.paddingMedium,
          bottom: AppTheme.paddingMedium,
          child: FloatingActionButton.extended(
            onPressed: onBack,
            backgroundColor: AppTheme.darkColor,
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            label: Text(
              'Tillbaka',
              style: AppTheme.textFont.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String title;
  final String content;

  const _InfoBox({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.paddingMediumSmall),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(AppTheme.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.textFont.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(content, style: AppTheme.textFont.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}
