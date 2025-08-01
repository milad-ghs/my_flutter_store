import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/item_count_provider.dart';
import 'package:store/providers/product_data_provider.dart';
import 'package:store/providers/title_provider.dart';
import 'package:store/screens/intro/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductDataProvider()),
        ChangeNotifierProvider(create: (context) => TitleProvider()),
        ChangeNotifierProvider(create: (context) => ItemCountProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: GoogleFonts.openSansTextTheme()),
        title: 'Store',
        home: SplashScreen(),
      ),
    );
  }
}
