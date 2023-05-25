import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_apps/my_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> navigatorKey =
        GlobalKey<NavigatorState>(); // ini dari flutter toast
    return GetMaterialApp(
      title: 'Permission_apps',
      debugShowCheckedModeBanner: false,
      builder: FToastBuilder(), // ini dari flutter toast
      navigatorKey: navigatorKey, // ini dari flutter toast
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
