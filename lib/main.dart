import 'package:duas/routemanagement/all_pages.dart';
import 'package:duas/routemanagement/screen_bindings.dart';
import 'package:duas/routemanagement/set_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: rSplashScreen,
      getPages: AllPages.getPages(),
      initialBinding: ScreenBinding(),
    );
  }
}
