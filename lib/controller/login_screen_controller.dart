import 'dart:convert' as convert;

import 'package:duas/custom/components.dart';
import 'package:duas/routemanagement/set_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../custom/ip_settings.dart';

class LoginScreenController extends GetxController {
  String screenName = 'login';
  Components comnnts = Components();
  var url = Uri.parse('http://$kPrimaryId/duas_php_files/login.php');

  String userName = '';

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  void gotoDashboard() {
    Get.toNamed(rHomeScreen);
  }

  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    comnnts.showDialog(false);
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode({
            'name': name.text,
            'password': password.text,
          }));

      var result = convert.jsonDecode(response.body);
      if (result['result'] == 'true') {
        userName = result['name'];
        comnnts.hideDialog();
        prefs.setString('isUser', 'true');
        prefs.setString('username', result['name']);
        Get.offAndToNamed(rHomeScreen, arguments: userName);
      } else {
        comnnts.hideDialog();
        comnnts.myToast("ERROR..!");
      }
    } catch (er) {
      comnnts.hideDialog();
      comnnts.myToast("ERROR...!");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
