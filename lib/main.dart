import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:store/providers/auth_provider.dart';
import 'package:store/providers/bottom_nav_provider.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/item_count_provider.dart';
import 'package:store/providers/product_data_provider.dart';
import 'package:store/providers/theme_provider.dart';
import 'package:store/providers/title_provider.dart';
import 'package:store/screens/intro/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/app_theme.dart';
import 'models/hive/cart_item_hive.dart';
import 'models/user/user.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cartBox');
  await Hive.openBox<User>('users');
  await Hive.openBox('auth');

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
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) =>ThemeProvider()),
        ChangeNotifierProvider(create: (context) =>AuthProvider()..loadUser()),
      ],

      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider , child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeProvider.themeMode,
            title: 'Store',
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
