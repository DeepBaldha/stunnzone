import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stunnzone/auth/customer_login.dart';
import 'package:stunnzone/auth/customer_signup.dart';
import 'package:stunnzone/main_screens/cart.dart';
import 'package:stunnzone/main_screens/customer_home.dart';
import 'package:stunnzone/main_screens/supplier_home.dart';
import 'package:stunnzone/main_screens/welcome.dart';
import 'auth/supplier_login.dart';
import 'auth/supplier_signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/welcome_screen',
      routes: {
        '/welcome_screen': (context) => const WelcomeScreen(),
        '/customer_home': (context) => const CustomerHomeScreen(),
        '/customer_home/cart_screen': (context) => const CartScreen(),
        '/supplier_home': (context) => const SupplierHomeScreen(),
        '/customer_signup': (context) => const CustomerRegister(),
        '/customer_login': (context) => const CustomerLogin(),
        '/supplier_signup': (context) => const SupplierRegister(),
        '/supplier_login': (context) => const SupplierLogin(),
      },
    );
  }
}
