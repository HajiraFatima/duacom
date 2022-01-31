import 'dart:async';

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

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> getRecentRecords() async {
    recents10Records.clear();
    var res = await http.get(url);
    var data = convert.jsonDecode(res.body);
    if (data['status'] == 'true') {
      for (var fetch in data['result']) {
        recents10Records.add(DashboardModel.fromJson(fetch));
      }
    }
  }

  void isSet() async {
    var res = await http.get(line);
    var data = convert.jsonDecode(res.body);
    if (data['status'] == 'true') {
      if (data['result']['isSet'] == '1') {
        getLastLine();
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
