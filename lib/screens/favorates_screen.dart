import 'package:flutter/material.dart';

import '../core/app_color.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColor.backgroundLight,
      body: Center(
        child: Text('Favorites'),
      ),
    ));
  }
}
