import 'package:duas/controller/splash_screen_controller.dart';
import 'package:duas/controller/view_by_accounts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Container(
        color: Colors.white,
          height: Get.height,
          width: Get.width,
          child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${controller.screenName}',style: TextStyle(
                    color: Colors.white,
                  ),),
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/dua_logo.png')
                      )
                    ),
                  ),
                ],
              )),
    )));
  }
}
