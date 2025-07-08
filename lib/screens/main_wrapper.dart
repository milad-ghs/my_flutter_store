import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:store/screens/cart_page.dart';
import 'package:store/core/constant.dart';
import 'package:store/screens/profile.dart';
import 'package:store/screens/setting.dart';

import '../providers/title_provider.dart';
import 'bottom_nav.dart';
import 'home_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController pageController = PageController(initialPage: 0);

  void _pageListener() {
    if (!mounted) return;
    int page = pageController.page?.round() ?? 0;
    Provider.of<TitleProvider>(context, listen: false).updateText(page);
  }

  @override
  void initState() {
    super.initState();
    pageController.removeListener(_pageListener);
    pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: bgColor,
      drawer: Drawer(),
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: backgroundColor,
        shape: CircleBorder(),
        child: Icon(Icons.store, color: Colors.black54),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: SvgPicture.asset('assets/icons/menu.svg'),
        ),
        backgroundColor: Colors.white.withAlpha(100),
        title: Consumer<TitleProvider>(
          builder: (context, titleProvider, child) {
            return Text(titleProvider.text);
          },
        ),

        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/notification.svg'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(controller: pageController),
      body: PageView(
        controller: pageController,
        children: [HomePage(), Setting(), Profile(), CartPage()],
      ),
    );
  }
}
