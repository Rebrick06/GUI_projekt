import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/widgets/shopping_panel.dart';
import 'package:imat_app/widgets/base_app_bar.dart';
import 'package:imat_app/widgets/control_panel.dart';
import 'package:imat_app/widgets/product_card.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    var iMat = context.watch<ImatDataHandler>();
    var products = iMat.selectProducts;

    final size = MediaQuery.of(context).size;
    double width = size.width * 0.5;
    double height = size.height * 0.75;

    // Det finns en version utan gridDelegate nedan.
    // Den kan vara enklare att förstå.
    // Denna version har fördelen att kort skapas on-demand.
    return Scaffold(
      //header
      appBar: const BaseAppBar(),
      //Body
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Scrollbar vänstersida
                Expanded(
                  flex: 2,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: AppTheme.paddingMediumSmall,
                            bottom: AppTheme.paddingMediumSmall,
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
                        padding: const EdgeInsets.only(
                          right: AppTheme.paddingSmall,
                          left: AppTheme.paddingSmall,
                        ),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final product = products[index];
                              return ProductCard(product, iMat);
                            },
                            childCount: products.length,
                          ),
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
                  ),
                ),

                // Fast kassa
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppTheme.paddingSmall,
                  ),
                  child: SizedBox(
                    height: height,
                    child: ShoppingPanel(400, iMat),
                  ),
                ),
              ],
            ),
          ),

          // TODO: MOVE FOOTER OUT
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
