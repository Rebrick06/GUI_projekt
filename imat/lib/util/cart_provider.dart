
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = []; 

  List<CartItem> get items => _items; 

  void addItem(Product product) {
    // lagg till produkt 
    notifyListeners(); 
  }

  double get total => ...; 

}