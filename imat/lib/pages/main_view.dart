import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/pages/product_detail_page.dart';
import 'package:imat_app/widgets/shopping_panel.dart';
import 'package:imat_app/widgets/base_app_bar.dart';
import 'package:imat_app/widgets/control_panel.dart';
import 'package:imat_app/widgets/product_card.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Product? _selectedProduct;

  @override
  Widget build(BuildContext context) {
    var iMat = context.watch<ImatDataHandler>();
    var products = iMat.selectProducts;

    final size = MediaQuery.of(context).size;
    double width = size.width * 0.5;
    double height = size.height * 0.75;

    return Scaffold(
      appBar: const BaseAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // ── Left side ────────────────────────────────────
                Expanded(
                  flex: 2,
                  child:
                      _selectedProduct == null
                          // Product grid
                          ? CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppTheme.paddingMediumSmall,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: width,
                                      child: ControlPanel(),
                                    ),
                                  ),
                                ),
                              ),
                              SliverPadding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppTheme.paddingSmall,
                                ),
                                sliver: SliverGrid(
                                  delegate: SliverChildBuilderDelegate((
                                    context,
                                    index,
                                  ) {
                                    final product = products[index];
                                    return ProductCard(
                                      product,
                                      iMat,
                                      onTap:
                                          () => setState(
                                            () => _selectedProduct = product,
                                          ),
                                    );
                                  }, childCount: products.length),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: AppTheme.paddingSmall,
                                        mainAxisSpacing: AppTheme.paddingSmall,
                                        childAspectRatio: 4 / 3,
                                      ),
                                ),
                              ),
                            ],
                          )
                          // Product detail
                          : ProductDetailPage(
                            product: _selectedProduct!,
                            iMat: iMat,
                            onBack:
                                () => setState(() => _selectedProduct = null),
                          ),
                ),

                // ── Shopping panel (always visible) ──────────────
                Padding(
                  padding: const EdgeInsets.only(left: AppTheme.paddingSmall),
                  child: SizedBox(
                    height: height,
                    child: ShoppingPanel(400, iMat),
                  ),
                ),
              ],
            ),
          ),

          Container(
            color: AppTheme.mainColor,
            height: 20,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
