import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:duas/custom/components.dart';
import 'package:duas/models/dashboard_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class ViewByAccountsController extends GetxController {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController msisdn = TextEditingController();
  String accountType = '';
  String screenName = 'Recents';
  RxList<DashboardModel> recents10Records = RxList<DashboardModel>();
  RxString date = ''.obs;
  RxString nowTime = ''.obs;
  RxString pleasewait = 'Search A Record...'.obs;
  TextEditingController searchByValue = TextEditingController();

  var url = Uri.parse('https://mwdomain.waqasmehmood.com/duas/view_by_accounts.php');
  var url2 = Uri.parse('https://mwdomain.waqasmehmood.com/duas/view_by_msisdn.php');

  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  Components comnnts = Components();
void validate(){
  if(formkey.currentState!.validate()){

    getRecords();
  }
}
  void getRecords() async {
    comnnts.showDialog(false);
    recents10Records.clear();
    var res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(<String, dynamic>{
          'searchByValue': searchByValue.text,
        }));
    var data = convert.jsonDecode(res.body);
    if (data['status'] == 'true') {
      comnnts.hideDialog();
      pleasewait.value = 'Search A Record';
      for (var fetch in data['result']) {
        recents10Records.add(DashboardModel.fromJson(fetch));
      }
    }else{
      comnnts.hideDialog();
      pleasewait.value = 'No Any Record Found';
    }
  }
  String? searchValidation(value) {
    if (value.replaceAll(new RegExp(r"\s+"), "").length < 3) {
      return "value must be at least 3 digits long";
    } else {
      return null;
    }
  }
  // void getTimeAndDate() {
  //   final DateTime now = DateTime.now();
  //   nowTime.value = DateFormat('hh:mm:ss a').format(now);
  //   date.value = Components().getDate();
  // }
  void tesPrint(DashboardModel i) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    String line = prfs.getString('lastLine')!;
    bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        if(i.selectedAccount=='Post Paid Bill'){
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

        }else{
          bluetooth.printCustom("---------------------------------", 3, 0);
          bluetooth.printCustom("Dua  Communication", 5, 1);
          bluetooth.printNewLine();
          bluetooth.printCustom("Oppst: Maryam marraige Hall near", 3, 1);
          bluetooth.printCustom("Zulfiqar Masjid Hirabad", 3, 1);
          bluetooth.printCustom("Contact:03033111126", 3, 1);
          bluetooth.printNewLine();
          bluetooth.printLeftRight("time", "date", 0);
          bluetooth.printCustom("---------------------------------", 3, 0);
          bluetooth.printLeftRight("TrxID", i.trxId, 0);
          bluetooth.printLeftRight("Name", i.customerName, 0);
          bluetooth.printLeftRight("MSISDN", i.msisdn, 0);
          bluetooth.printLeftRight("Account", i.selectedAccount, 0);
          bluetooth.printLeftRight("Amount", i.amount, 0);
          bluetooth.printCustom("---------------------------------", 3, 0);
          bluetooth.printCustom("Receipt Charges Rs.10/=", 3, 1);
          bluetooth.printCustom(line, 3, 1);
          bluetooth.printNewLine();
          bluetooth.printNewLine();
          bluetooth.paperCut();
        }
      } else {
        comnnts.myToast("Please connect your printer!");
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
