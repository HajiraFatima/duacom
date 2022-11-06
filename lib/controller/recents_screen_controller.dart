import 'dart:convert' as convert;

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:duas/custom/components.dart';
import 'package:duas/models/dashboard_screen_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom/ip_settings.dart';

class RecentScreenController extends GetxController {
  String screenName = 'Recents';
  RxString date = ''.obs;
  RxString nowTime = ''.obs;
  RxBool isSearchOn = false.obs;
  TextEditingController search = TextEditingController();
  RxList<DashboardModel> recents10Records = RxList<DashboardModel>();

  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  Components comnnts = Components();
  var url = Uri.parse('http://$kPrimaryId/duas_php_files/recents.php');
  RxString selectedAccount = 'Easy Paisa'.obs;
  RxString pleasewait = 'Please wait...'.obs;
  List<String> accountTypesList = [
    'Jazz Cash',
    'Easy Paisa',
    'U Paisa',
    'Omni',
    'Post Paid Bill'
  ];
  List accountTypesImages = [
    'jazzcash.jpg',
    'easypaisa.png',
    'upaisa.png',
    'omni.png',
    'postpaid.png'
  ];
  List<DropdownMenuItem<String>> getItems() {
    List<DropdownMenuItem<String>> items = [];

    for (int i = 0; i < accountTypesList.length; i++) {
      items.add(DropdownMenuItem(
        child: Container(
          height: 50,
          child: ListTile(
            leading: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.white,
                child: Image.asset('assets/${accountTypesImages[i]}')),
            title: Text(accountTypesList[i]),
          ),
        ),
        value: accountTypesList[i],
      ));
    }

    return items;
  }

  Future<void> getRecentRecords() async {
    var todayDate = comnnts.getDate();
    recents10Records.clear();
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode({
          'todayDate': todayDate,
          'selectedAccount': false,
        }));
    var data = convert.jsonDecode(response.body);
    if (data['status'] == 'true') {
      pleasewait.value = 'Please wait...';

      for (var fetch in data['result']) {
        recents10Records.add(DashboardModel.fromJson(fetch));
      }
    } else {
      pleasewait.value = 'No Any Record Found';
    }
  }

  Future<void> getRecentRecordsByAccount() async {
    comnnts.showDialog(false);
    var todayDate = comnnts.getDate();
    recents10Records.clear();
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode({
          'todayDate': todayDate,
          'selectedAccount': selectedAccount.value
        }));
    var data = convert.jsonDecode(response.body);
    print(data);
    if (data['status'] == 'true') {
      comnnts.hideDialog();
      pleasewait.value = 'Please wait...';
      for (var fetch in data['result']) {
        recents10Records.add(DashboardModel.fromJson(fetch));
      }
    } else if (data['status'] == 'false') {
      comnnts.hideDialog();
      pleasewait.value = 'No Any Record Found';
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

  void tesPrint(DashboardModel i) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    String line = prfs.getString('lastLine')!;
    bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        if (i.selectedAccount == 'Post Paid Bill') {
          bluetooth.printCustom("--------------------------------", 0, 0);
          bluetooth.printCustom("DUA COMMUNICATION", 3, 1);
          bluetooth.printCustom("Oppst: Maryam marraige Hall near", 1, 1);
          bluetooth.printCustom("Zulfiqar Masjid Hirabad", 1, 1);
          bluetooth.printCustom("Contact:03033111126", 1, 1);
          bluetooth.printNewLine();
          bluetooth.printLeftRight("$nowTime", "$date", 0);
          bluetooth.printCustom("--------------------------------", 0, 0);
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
        }
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
