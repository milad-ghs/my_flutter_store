import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../core/app_color.dart';
import '../../providers/cart_provider.dart';
import '../../providers/auth_provider.dart';
import '../login.dart';
import '../main_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthProvider>();
      auth.loadUser();

      Future.delayed(const Duration(seconds: 3), () async {
        if (!mounted) return;
        final auth = context.read<AuthProvider>();

        if (auth.isLoggedIn) {
          final userId = auth.currentUser!.phoneNumber ;
          await context.read<CartProvider>().initUserCart(userId);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainWrapper()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DelayedWidget(
              delayDuration: const Duration(milliseconds: 200),
              animationDuration: const Duration(milliseconds: 2000),
              animation: DelayedAnimations.SLIDE_FROM_TOP,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/images/store_logo.png',
                  width: width * 0.7,
                ),
              ),
            ),
            const SizedBox(height: 50),
            LoadingAnimationWidget.threeArchedCircle(
              color: AppColor.primary,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
