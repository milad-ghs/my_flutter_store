import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_color.dart';
import '../providers/bottom_nav_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../providers/theme_provider.dart';

class BottomNav extends StatelessWidget {
  final PageController controller;
  final int currentIndex;

  const BottomNav({
    super.key,
    required this.controller,
    required this.currentIndex,
  });

  final List<IconData> navItems = const [
    Icons.home,
    Icons.settings,
    Icons.person,
    Icons.favorite,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index){
            controller.jumpToPage(index);
            context.read<BottomNavProvider>().setIndex(index);
          },
          backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
          elevation: 5,
          unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
          selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
          selectedLabelStyle: TextStyle(height: 1.6),
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels : false,


          items: [
            BottomNavigationBarItem(icon: AnimatedScale(
                scale: currentIndex == 0 ? 1.2 : 1.0,
                duration: Duration(milliseconds: 100),
                child: Icon(PhosphorIcons.houseLine(PhosphorIconsStyle.regular))),label: 'home'),
            BottomNavigationBarItem(icon: AnimatedScale(
                scale: currentIndex == 1 ? 1.2 : 1.0,
                duration: Duration(milliseconds: 100),
                child: Icon(PhosphorIcons.user(PhosphorIconsStyle.regular))),label: 'profile'),
            BottomNavigationBarItem(icon: AnimatedScale(
                scale: currentIndex == 2 ? 1.2 : 1.0,
                duration: Duration(milliseconds: 100),
                child: Icon(PhosphorIcons.heart(PhosphorIconsStyle.regular))),label: 'favorites'),
          ]),
    );
  }
}

