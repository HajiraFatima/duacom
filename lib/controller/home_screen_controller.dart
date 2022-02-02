import 'dart:async';

import 'package:duas/custom/components.dart';
import 'package:duas/models/dashboard_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenController extends GetxController {
  RxList<DashboardModel> recents10Records = RxList<DashboardModel>();

  var url = Uri.parse('https://mwdomain.waqasmehmood.com/duas/recents.php');
  var line = Uri.parse('https://mwdomain.waqasmehmood.com/duas/view_line.php');
  RxBool isScreenSet = false.obs;
  RxString nowTime = ''.obs;
  Components comnnts = Components();
  RxString userName = 'admin'.obs;
  RxString pleasewait = 'Please wait...'.obs;
  void getTime() {
    final DateTime now = DateTime.now();
    nowTime.value = DateFormat('hh:mm:ss a').format(now);
  }

  Future<void> getLastLine() async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    var res = await http.get(line);
    var data = convert.jsonDecode(res.body);
    if (data['status'] == 'true') {
      prfs.setString('lastLine', data['result']['line']);
      prfs.setString('isSet', data['result']['isSet']);

    }
  }

  void getUsername()async{
    SharedPreferences prfs = await SharedPreferences.getInstance();
  userName.value = Get.arguments?? prfs.getString('username');
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> getRecentRecords() async {
    recents10Records.clear();
    var todayDate = comnnts.getDate();
    recents10Records.clear();

    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode({
          'todayDate': todayDate,
          'selectedAccount':false,

        }));
    var data = convert.jsonDecode(response.body);
    if (data['status'] == 'true') {
      pleasewait.value = 'Please wait...';
      for (var fetch in data['result']) {
        recents10Records.add(DashboardModel.fromJson(fetch));
      }
    }else{
      pleasewait.value = 'No Any Record Found';
    }
  }

  void isSet() async {
    var res = await http.get(line);
    var data = convert.jsonDecode(res.body);
    if (data['status'] == 'true') {
      if (data['result']['isSet'] == '1') {
        getLastLine();
        getUsername();
        getRecentRecords();
        isScreenSet.value = false;
      } else {
        isScreenSet.value = true;
      }
    }
  }

  @override
  void onInit() {
    isSet();

    Timer.periodic(Duration(seconds: 1), (timer) => getTime());

    super.onInit();
  }
}
