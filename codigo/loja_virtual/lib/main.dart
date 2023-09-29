import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:loja_virtual/screens/product_screen.dart';
import 'package:loja_virtual/screens/products_screen.dart';
import 'package:loja_virtual/firebase_options.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/base_screen.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:loja_virtual/screens/splash_screen.dart';
import 'models/category_manager.dart';
import 'models/products/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static const gradient = LinearGradient(colors: [
    Color.fromARGB(255, 255, 97, 97),
    Color.fromARGB(253, 253, 204, 204)
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static Color primary = const Color(0xFFFF6161);
  static String? init;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserManager(),
            lazy: false,
          ),
          ChangeNotifierProvider(
            create: (_) => CategoryManager(),
            lazy: false,
          ),
          ChangeNotifierProvider(
            create: (_) => ProductManager(MyApp.init),
            lazy: true,
          ),
        ],
        child: MaterialApp(
          title: 'Instituto GCM',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: const Color(0xFFFF6161),
              scaffoldBackgroundColor: Colors.transparent,
              appBarTheme: const AppBarTheme(elevation: 0),
              visualDensity: VisualDensity.adaptivePlatformDensity),
          initialRoute: '/splash',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/splash':
                return MaterialPageRoute(builder: (_) => const SplashScreen());
              case '/base':
                return MaterialPageRoute(builder: (_) => BaseScreen());
              case '/login':
                return MaterialPageRoute(builder: (_) => LoginScreen());
              case '/signup':
                return MaterialPageRoute(builder: (_) => const SignupScreen());
              case '/product':
                return MaterialPageRoute(builder: (_) =>  ProductScreen(
                   product: settings.arguments as Product,
                ));
              case '/products':
                return MaterialPageRoute(builder: (_) =>  const ProductsScreen());
              default:
                return MaterialPageRoute(builder: (_) => BaseScreen());
            }
          },
        ));
  }
}
