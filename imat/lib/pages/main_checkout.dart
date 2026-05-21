import 'package:flutter/material.dart';
import 'package:imat_app/widgets/base_app_bar.dart';
import 'package:imat_app/app_theme.dart';

class MainCheckout extends StatelessWidget {
  const MainCheckout({super.key}); 

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //var iMat = context.watch<ImatDataHandler>();
    //var products = iMat.selectProducts;

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
          Expanded(
            child: Row(  
                    ),
                  ),
                  ],
                ),
    );
                
            
               

  }

}