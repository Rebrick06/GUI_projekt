import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    var iMat = context.watch<ImatDataHandler>();
    var products = iMat.selectProducts;

    // Det finns en version utan gridDelegate nedan.
    // Den kan vara enklare att förstå.
    // Denna version har fördelen att kort skapas on-demand.
    return Scaffold(
      
      body: Column( 
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color.fromRGBO(176, 230, 185, 1), 
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "IMats produkter för faan",
                  style: AppTheme.titleFont
                )
              ],
            )
          ),
          
            
              Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.paddingSmall),
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
            color: Color.fromRGBO(176, 230, 185, 1), 
            height: 20,
            width: double.infinity,
            // FOoooooT
          ),
        ],
      ),
    );
  }
}
