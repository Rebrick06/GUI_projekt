
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) =>
        ProductCard(product: products[index]), 
    ); 
  } 
}