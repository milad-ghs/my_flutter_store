import 'package:flutter/cupertino.dart';

class ItemCountProvider extends ChangeNotifier{
   late int _num = 1;
   int get num => _num;

   void increment(){
     _num++;
     notifyListeners();
   }
   void decrement(){
     if(num > 0){
       _num --;
     }else{}
     notifyListeners();
   }
}