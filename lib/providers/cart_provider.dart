import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  bool isInCart(String productId) => _items.containsKey(productId);

  void addItem({
    required String productId,
    required String title,
    required double price,
    required String image,
  }) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (oldItem) => CartItem(
          id: oldItem.id,
          title: oldItem.title,
          price: oldItem.price,
          quantity: oldItem.quantity + 1,
          image: oldItem.image,
        ),
      );
    } else {
      _items[productId] = CartItem(
        id: DateTime.now().toString(),
        title: title,
        price: price,
        quantity: 1,
        image: image,
      );
    }
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      final item = _items[productId]!;
      _items.update(
        productId,
        (_) => CartItem(
          id: item.id,
          title: item.title,
          price: item.price,
          quantity: item.quantity + 1,
          image: item.image,
        ),
      );
      notifyListeners();
    }
  }

  void decreaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      final item = _items[productId]!;
      if (item.quantity > 1) {
        _items.update(
          productId,
          (_) => CartItem(
            id: item.id,
            title: item.title,
            price: item.price,
            quantity: item.quantity - 1,
            image: item.image,
          ),
        );
      } else {
        // _items.remove(productId);
      }
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
