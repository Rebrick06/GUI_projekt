
import 'package:flutter/material.dart';

class CartPanel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>(); 

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) => 
              CartItemRow(item: cart.items[index]), 
            ),
          ),
        Text('Totalt: ${cart.total} kr'),
      ],
    );
  }
}