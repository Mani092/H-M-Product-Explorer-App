import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hnmapplication/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'H&M Product Explorer',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ProductListScreen(),
    );
  }
}

