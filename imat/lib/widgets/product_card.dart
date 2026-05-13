
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product; 

  const ProductCard({super.key, required this.product}); 

  @override 
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(product.imagePath), 
          Text(product.name), 
          ElevatedButton(
            onPressed: () {
              context.read<CartProvider>().addItem(product);
            },
            child: const Text('lagg i varukorg'),
          ),
        ],
      ),
    )
  }
}