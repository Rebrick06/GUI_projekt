
import 'package:flutter/material.dart';
import 'package:flutter/product_grid.dart';
import 'package:flutter/category_filter.dart';
import 'package:flutter/cart_panel.dart';

class MainView extends StatelessWidget {
  const MainView({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      AppBar: _buildAppBar(), 
      body: Row(
        children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  CategoryFilter(), 
                  Expanded(child: ProductGrid()),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: CartPanel(),
          ) 
        ],
      ),  
    );
  }
}