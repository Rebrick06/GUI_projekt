
import 'package:flutter/material.dart';

class CartItemRow extends StatelessWidget {
  final CartItem item; 

  const CartItemRow({super.key, required this.item}); 

  @override 
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(item.product.name),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
      ],
    );
  }
}