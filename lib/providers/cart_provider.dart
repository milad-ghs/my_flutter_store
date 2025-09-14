import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/hive/cart_item_hive.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  Box<CartItem>? _cartBox;
  String? _userId;

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

  /// فراخوانی بعد از لاگین کاربر
  Future<void> initUserCart(String userId) async {
    _userId = userId;
    _cartBox = await Hive.openBox<CartItem>('cartBox_$userId');
    _items.clear();
    _items.addEntries(_cartBox!.toMap().entries.map((e) => MapEntry(e.key, e.value)));
    notifyListeners();
  }

  void addItem({
    required String productId,
    required String title,
    required double price,
    required String image,
  }) {
    if (_items.containsKey(productId)) {
      final oldItem = _items[productId]!;
      final updatedItem = CartItem(
        id: oldItem.id,
        title: oldItem.title,
        price: oldItem.price,
        quantity: oldItem.quantity + 1,
        image: oldItem.image,
      );
      _items[productId] = updatedItem;
      _cartBox?.put(productId, updatedItem);
    } else {
      final newItem = CartItem(
        id: DateTime.now().toString(),
        title: title,
        price: price,
        quantity: 1,
        image: image,
      );
      _items[productId] = newItem;
      _cartBox?.put(productId, newItem);
    }
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      final item = _items[productId]!;
      final updatedItem = CartItem(
        id: item.id,
        title: item.title,
        price: item.price,
        quantity: item.quantity + 1,
        image: item.image,
      );
      _items[productId] = updatedItem;
      _cartBox?.put(productId, updatedItem);
      notifyListeners();
    }
  }

  void decreaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      final item = _items[productId]!;
      if (item.quantity > 1) {
        final updatedItem = CartItem(
          id: item.id,
          title: item.title,
          price: item.price,
          quantity: item.quantity - 1,
          image: item.image,
        );
        _items[productId] = updatedItem;
        _cartBox?.put(productId, updatedItem);
      } else {
        removeItem(productId);
      }
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    _cartBox?.delete(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _cartBox?.clear();
    notifyListeners();
  }

  /// زمان خروج کاربر
  Future<void> logout() async {
    if (_userId != null) {
      clearCart();
      await _cartBox?.close();
      _cartBox = null;
      _userId = null;
    }
  }
}
