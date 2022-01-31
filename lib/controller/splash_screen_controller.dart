import 'dart:async';

import 'package:duas/routemanagement/set_routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  String screenName = 'Splash Screen';
  var line = Uri.parse('https://mwdomain.waqasmehmood.com/duas/view_line.php');



  Future<void> getLastLine() async {
    await Future.delayed(const Duration(seconds: 3), () {});
        gotoDashboard();
  }



  void gotoDashboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? isUser = prefs.getString('isUser');

    if (isUser == 'true') {
      Get.offAndToNamed(rHomeScreen);
    } else {
      Get.offAndToNamed(rLoginScreen);
    }
  }

  @override
  void onReady() {
    getLastLine();
    // TODO: implement onReady
    super.onReady();
  }
}
