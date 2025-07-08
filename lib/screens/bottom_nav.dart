import 'package:flutter/material.dart';

import '../core/constant.dart';

class BottomNav extends StatelessWidget {
  PageController controller;
  BottomNav({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return  BottomAppBar(
      color: secondaryColor,
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height:57 ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width /2 - 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){
                      controller.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);

                  }, icon: Icon(Icons.home)),
                  IconButton(onPressed: (){
                    controller.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
                  }, icon: Icon(Icons.settings)),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width /2 - 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){
                    controller.animateToPage(2, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);

                  }, icon: Icon(Icons.person)),
                  IconButton(onPressed: (){
                    controller.animateToPage(3, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
                    print('page 4');
                  }, icon: Icon(Icons.card_travel)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
