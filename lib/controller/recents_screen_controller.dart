import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:duas/custom/components.dart';
import 'package:duas/models/dashboard_screen_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class RecentScreenController extends GetxController {
  String screenName = 'Recents';
  RxString date = ''.obs;
  RxString nowTime = ''.obs;
  RxBool isSearchOn = false.obs;
  TextEditingController search = TextEditingController();
  RxList<DashboardModel> recents10Records = RxList<DashboardModel>();
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  Components comnnts = Components();
  var url = Uri.parse('https://mwdomain.waqasmehmood.com/duas/recents.php');
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

  RxList filteredRecord = [].obs;
  void filterTest(val) {
    List allItems = [];

    for (var recent in recents10Records) {
      allItems.add(recent.msisdn);
      for (var items in allItems) {
        if (items.contains(val)) {
          filteredRecord.add(recent);
        }
        // ignore: avoid_print
        print(filteredRecord);
      }
    }
  }

  // void filterTest(value) {
  //   filteredRecord.clear();
  //   for (var recent in recents10Records) {
  //     if (recent.msisdn.contains(value)) {
  //       recent.msisdn.contains(other)=>print()
  //       if (filteredRecord.isNotEmpty) {
  //         // for (var val in filteredRecord) {
  //         //   if (val != value) {
  //         //     print("::::::: $value");
  //         //     filteredRecord.add(recent.msisdn);
  //         //   }
  //         // }
  //       } else {
  //         // filteredRecord.add(recent.msisdn);
  //       }
  //     }

  //     // print(filteredRecord);
  //   }
  // }

  void tesPrint(DashboardModel i) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    String line = prfs.getString('lastLine')!;
    bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        bluetooth.printCustom("--------------------------------", 0, 0);
        bluetooth.printCustom("DUA COMMUNICATION", 3, 1);
        bluetooth.printCustom("Oppst: Maryam marraige Hall near", 1, 1);
        bluetooth.printCustom("Zulfiqar Masjid Hirabad", 1, 1);
        bluetooth.printCustom("Contact:03033111126", 1, 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("$nowTime", "$date", 0);
        bluetooth.printCustom("--------------------------------", 0, 0);
        bluetooth.printLeftRight("TrxID", i.trxId, 0);
        bluetooth.printLeftRight("Name", i.customerName, 0);
        bluetooth.printLeftRight("MSISDN", i.msisdn, 0);
        bluetooth.printLeftRight("Account", i.selectedAccount, 0);
        bluetooth.printLeftRight("Amount", i.amount, 0);
        bluetooth.printCustom("--------------------------------", 1, 0);
        bluetooth.printCustom("Receipt Charges Rs.10/=", 1, 1);
        bluetooth.printCustom(line, 1, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      } else {
        comnnts.myToast("Please connect your printer!");
      }
    });
  }

  void getTime() {
    final DateTime now = DateTime.now();
    nowTime.value = DateFormat('hh:mm:ss a').format(now);
    date.value = Components().getDate();
  }

  @override
  void onInit() {
    getRecentRecords();
    getTime();
    // TODO: implement onInit
    super.onInit();
  }
}

