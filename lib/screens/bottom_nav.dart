import 'package:flutter/material.dart';

import '../core/constant.dart';

class BottomNav extends StatelessWidget {
  final PageController controller;
  const BottomNav({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return  BottomAppBar(
      color: secondaryColor,
      // shape: CircularNotchedRectangle(),
      // notchMargin: 8,
      child: SizedBox(
        height:57 ,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                  controller.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);

              }, icon: Icon(Icons.home,size: 25)),
              IconButton(onPressed: (){
                controller.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
              }, icon: Icon(Icons.settings,size: 25)),
              IconButton(onPressed: (){
                controller.animateToPage(2, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);

              }, icon: Icon(Icons.person,size: 25)),
              IconButton(onPressed: (){
                controller.animateToPage(3, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
              }, icon: Icon(Icons.card_travel,size: 25)),

            ],
          ),
        ),
      ),
    );
  }
}
