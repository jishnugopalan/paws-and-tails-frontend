import 'package:flutter/material.dart';
import 'package:paws_and_tails/customer/customer_dashboard.dart';
import 'package:paws_and_tails/login.dart';
import 'package:paws_and_tails/registration.dart';
import 'package:paws_and_tails/shop/add_product.dart';
import 'package:paws_and_tails/shop/shop_dashboard.dart';

import 'introslider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: LoginPage(),
      routes: {
        '/registration':(context)=>RegistrationPage(),
        '/login':(context)=>LoginPage(),
        '/customer':(context)=>CustomerDashboard(),
        '/shop':(context)=>ShopDashboard(),
        '/add-product':(context)=>AddProducts()
      },
    );
  }
}


