import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:store/core/constant.dart';
import 'package:store/providers/auth_provider.dart';
import 'package:store/screens/cart_page.dart';
import 'package:store/screens/profile.dart';
import 'package:store/screens/setting.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../core/app_color.dart';
import '../providers/bottom_nav_provider.dart';
import '../providers/title_provider.dart';
import '../widgets/cart_icon.dart';
import '../widgets/dialog_utils.dart';
import 'bottom_nav.dart';
import 'favorates_screen.dart';
import 'home_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final advancedDrawerController = AdvancedDrawerController();
  PageController pageController = PageController(initialPage: 0);

  void _pageListener() {
    if (!mounted) return;
    int page = pageController.page?.round() ?? 0;
    Provider.of<BottomNavProvider>(context, listen: false).setIndex(page);
    Provider.of<TitleProvider>(context, listen: false).updateText(page);
  }

  void openDrawer() {
    advancedDrawerController.showDrawer();
  }

  @override
  void initState() {
    super.initState();

    pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final auth = context.read<AuthProvider>();
    final user = auth.currentUser;
    final displayName = (user?.name != null && user!.name!.isNotEmpty) ? user.name : (user?.phoneNumber ?? "user");
    return AdvancedDrawer(
      drawerCloseSemanticLabel: 'close',
      backdrop: ValueListenableBuilder<AdvancedDrawerValue>(
        valueListenable: advancedDrawerController,
        builder: (context, value, child) {
          if (!value.visible) {
            return const SizedBox.shrink();
          }
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 105,
              height: 640,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadius * 2),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.white.withAlpha(115), Colors.transparent],
                ),
              ),
            ),
          );
        },
      ),
      openRatio: 0.7,
      openScale: 0.85,
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadius * 3),
      ),
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 500),
      controller: advancedDrawerController,
      backdropColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[700]
          : AppColor.primary,
      drawer: SafeArea(
        child: Container(
          // color: Colors.green,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 25),
                  child: GestureDetector(
                    onTap: (){
                      advancedDrawerController.hideDrawer();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withAlpha(60),
                      radius: 18,
                      child:Icon(PhosphorIcons.x(PhosphorIconsStyle.regular),color: Colors.white,) ,
                    ),

                  ),
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Container(
                    // padding : EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white60,width: 1)
                    ),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white.withAlpha(60),
                      backgroundImage: (user?.profileImagePath != null &&
                          File(user!.profileImagePath!).existsSync())
                          ? FileImage(File(user.profileImagePath!))
                          : null,
                      child: (user?.profileImagePath == null ||
                          !(File(user!.profileImagePath!).existsSync()))
                          ? Icon(
                        PhosphorIcons.user(PhosphorIconsStyle.regular),
                        size: 40,
                        color: Colors.white70,
                      )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      displayName!,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.8
                      ),
                    ),
                  ),
                ],
              ),
            ),
                Divider(endIndent: 18,
                  color: Colors.white.withAlpha(80),
                  thickness: 2,
                  indent: 24,
                ),
                DrawerBuild(
                  title: 'Profile',
                  icon: PhosphorIcons.userCircle(PhosphorIconsStyle.regular),
                  press: () {
                    pageController.jumpToPage(1);
                    advancedDrawerController.hideDrawer();
                  },
                ),
                // Divider(endIndent: 18,
                //   color: Colors.white.withAlpha(80),
                //   thickness: 2,
                //   indent: 24,
                // ),
                DrawerBuild(
                  title: 'Setting ',
                  press: () {
                    advancedDrawerController.hideDrawer();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                  },
                  icon: PhosphorIcons.gear(PhosphorIconsStyle.regular),
                ),
                // Divider(endIndent: 18,
                //   color: Colors.white.withAlpha(80),
                //   thickness: 2,
                //   indent: 24,
                // ),
                DrawerBuild(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                    advancedDrawerController.hideDrawer();
                  },
                  title: 'Orders',
                  icon: LineAwesomeIcons.cart_plus_solid,
                ),
                Divider(endIndent: 18,
                  color: Colors.white.withAlpha(80),
                  thickness: 2,
                  indent: 24,
                ),
                DrawerBuild(
                  title: 'Security',
                  press: () {},
                  icon: Icons.security,
                ),
                // Divider(endIndent: 18,
                //   color: Colors.white.withAlpha(80),
                //   thickness: 2,
                //   indent: 24,
                // ),
                DrawerBuild(
                  title: 'Log out',
                  press:()=> logout(context),
                  icon: PhosphorIcons.signOut(PhosphorIconsStyle.regular),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 25),
                  child: Text('version: 1.0.0+1',style: TextStyle(color: Colors.white,fontSize: 18),),
                )
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        key: _scaffoldKey,
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
              openDrawer();
            },
            icon: Icon(PhosphorIcons.list(PhosphorIconsStyle.regular)),
          ),
          backgroundColor:theme.appBarTheme.backgroundColor,
          foregroundColor: theme.appBarTheme.foregroundColor,
          title: Consumer<TitleProvider>(
            builder: (context, titleProvider, child) {
              return Text(titleProvider.text,style: theme.appBarTheme.titleTextStyle);
            },
          ),
          centerTitle: true,
          actions: [
            CartIconWithBadge(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar:Consumer<BottomNavProvider>(
          builder: (context,BottomNavProvider,child){
            return BottomNav(controller: pageController, currentIndex: BottomNavProvider.currentIndex);
          },
        ),
        body: PageView(
          controller: pageController,
          children: [HomePage(), Profile(), FavoritesScreen()],
        ),
      ),
    );
  }
}

class DrawerBuild extends StatefulWidget {
 final IconData icon;
  final VoidCallback press;
  final String title;

  const DrawerBuild({
    required this.press,
    required this.icon,
    required this.title,

    super.key,
  });

  @override
  State<DrawerBuild> createState() => _DrawerBuildState();
}

class _DrawerBuildState extends State<DrawerBuild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(horizontalTitleGap: 10,
        onTap: widget.press,
        leading: Icon(widget.icon, size: 32, color: AppColor.backgroundLight),
        minLeadingWidth: 10,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColor.backgroundLight,

          ),
        ),
      ),
    );
  }
}
