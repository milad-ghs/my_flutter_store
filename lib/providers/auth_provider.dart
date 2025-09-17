import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user/user.dart';
import 'package:path_provider/path_provider.dart';

class AuthProvider extends ChangeNotifier {
  final Box<User> _userBox = Hive.box<User>('users');
  final Box _authBox = Hive.box('auth');

  User? _currentUser;
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  /// بارگذاری کاربر لاگین‌شده (اگر قبلاً ذخیره شده)
  void loadUser() {
    final phone = _authBox.get('loggedInUser');
    if (phone != null) {
      try {
        _currentUser = _userBox.values.firstWhere((u) => u.phoneNumber == phone);
      } catch (_) {
        _currentUser = null;
      }
    }
  }

  User? getUserByPhone(String phone) {
    try {
      return _userBox.values.firstWhere((u) => u.phoneNumber == phone);
    } catch (_) {
      return null;
    }
  }

  /// اگر شماره وجود داشته باشه لاگین می‌کنه، در غیر اینصورت اکانت جدید می‌سازه و لاگین میکنه
  void loginOrRegister(String phone) {
    final existing = getUserByPhone(phone);
    if (existing != null) {
      _currentUser = existing;
    } else {
      final newUser = User(phoneNumber: phone);
      _userBox.add(newUser);
      _currentUser = newUser;
    }
    _authBox.put('loggedInUser', _currentUser!.phoneNumber);
    notifyListeners();
  }

  /// پس از اولین ورود، کاربر می‌تونه نامش رو تنظیم کنه
  void setProfileName(String name ) {
    if (_currentUser != null) {
      _currentUser!.name = name;

      _currentUser!.save(); // ذخیره در Hive
      notifyListeners();
    }
  }


  Future<void> setProfileImage(String imagePath) async {
    if (_currentUser != null) {
      try {
        final dir = await getApplicationDocumentsDirectory();
        final extension = imagePath.split('.').last;
        final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.$extension';
        final file = File(imagePath);

        if (!file.existsSync()) {
          print("❌ فایل وجود ندارد: $imagePath");
          return;
        }

        // کپی عکس در حافظه دائمی اپ
        final newImage = await file.copy(path);

        _currentUser!.profileImagePath = newImage.path;
        await _currentUser!.save();
        notifyListeners();
        print("Saved profile image to: ${newImage.path}");

      } catch (e) {
        print("❌ خطا در ذخیره عکس: $e");
      }
    }
  }


  void logout(BuildContext context) {
    // context.read<CartProvider>().clearCart();
    _currentUser = null;
    _authBox.delete('loggedInUser');
    notifyListeners();
  }
}
