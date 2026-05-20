import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
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

    // Det finns en version utan gridDelegate nedan.
    // Den kan vara enklare att förstå.
    // Denna version har fördelen att kort skapas on-demand.
    return Scaffold(

      appBar: const BaseAppBar(),

      body: Column( 
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              ControlPanel(width),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: AppTheme.paddingSmall, 
                left: AppTheme.paddingSmall,
              ),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 kolumner
                  crossAxisSpacing: AppTheme.paddingSmall,
                  mainAxisSpacing: AppTheme.paddingSmall,
                  childAspectRatio: 4 / 3,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];

                  return ProductCard(product, iMat);
                },
              ),
            ),
          ),
          
          Container(
            color: AppTheme.mainColor, 
            height: 20,
            width: double.infinity,
            // FOoooooT
          ),
        ],
      ),
    );
  }
}
