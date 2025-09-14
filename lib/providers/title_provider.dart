
import 'package:flutter/cupertino.dart';

class TitleProvider extends ChangeNotifier{
  static List<String> title = [
    'Store',
    'Profile',
    'Favorite'
  ];
  late String _text = title[0];

  String get text => _text;
  void updateText(int pageIndex) {
    _text = title[pageIndex];
    notifyListeners();
  }

}