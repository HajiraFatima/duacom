import 'package:duas/custom/components.dart';
import 'package:duas/routemanagement/set_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends GetxController {
  String screenName = 'login';
  Components comnnts = Components();
  var url = Uri.parse('https://mwdomain.waqasmehmood.com/duas/login.php');

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  void gotoDashboard() {
    Get.toNamed(rHomeScreen);
  }

  login() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     comnnts.showDialog(false);
    // if (name.text == 'duadua' && password.text == '123456') {
    //   comnnts.hideDialog();
    //   prefs.setString('isUser', 'true');
    //   Get.toNamed(rHomeScreen);
    // } else {
    //   comnnts.hideDialog();
    //   comnnts.myToast("ERROR..!");
    // }

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
      comnnts.hideDialog();
      prefs.setString('isUser', 'true');
      Get.offAndToNamed(rHomeScreen);
    } else {
      comnnts.hideDialog();
      comnnts.myToast("ERROR..!");
    }

    } catch(er) {
      comnnts.hideDialog();
      comnnts.myToast("ERROR...!");
    }
  }

  @override
  void onInit() {
    name.text = 'duadua';
    password.text = '123456';

    // TODO: implement onInit
    super.onInit();
  }
}
