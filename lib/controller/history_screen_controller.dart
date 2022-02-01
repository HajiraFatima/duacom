import 'dart:io';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:duas/custom/components.dart';
import 'package:duas/models/dashboard_screen_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:open_file/open_file.dart';

class HistoryScreenController extends GetxController {
  String screenName = 'History';
  RxString dateFrom = 'Date From'.obs;
  RxString dateTo = 'Date To'.obs;
  Components comnnts = Components();
  TextEditingController docName = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  RxString date = ''.obs;
  RxString nowTime = ''.obs;

  RxList<DashboardModel> records = RxList<DashboardModel>();
  var url = Uri.parse('https://mwdomain.waqasmehmood.com/duas/fetch.php');

  Future<void> getRecordsByDate() async {
    comnnts.showDialog(false);
    records.clear();

    try {
      var res = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(<String, dynamic>{
            'dateFrom': dateFrom.value,
            'dateTo': dateTo.value,
          }));
      var data = convert.jsonDecode(res.body);
      if (data['status'] == 'true') {
        comnnts.hideDialog();
        for (var fetch in data['result']) {
          records.add(DashboardModel.fromJson(fetch));
        }
      } else {
        comnnts.hideDialog();
        comnnts.showDialog(true, title: 'ERROR...!', error: true);
      }
    } catch (er) {
      comnnts.hideDialog();
      comnnts.showDialog(true, title: 'ERROR...!', error: true);

    }
  }

  void exelRecord() async {
    final Workbook workbook = new Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').setText('name');
    sheet.getRangeByName('B1').setText('msisdn');
    sheet.getRangeByName('C1').setText('account');
    sheet.getRangeByName('D1').setText('amount');
    sheet.getRangeByName('E1').setText('trxId');
    sheet.getRangeByName('F1').setText('date');
    sheet.getRangeByName('G1').setText('time');

    for (var i = 0; i < records.length; i++) {
      sheet.getRangeByName('A${i + 2}').setText(records[i].customerName);
      sheet.getRangeByName('B${i + 2}').setText(records[i].msisdn);
      sheet.getRangeByName('C${i + 2}').setText(records[i].selectedAccount);
      sheet.getRangeByName('D${i + 2}').setText(records[i].amount);
      sheet.getRangeByName('E${i + 2}').setText(records[i].trxId);
      sheet.getRangeByName('F${i + 2}').setText(records[i].date);
      sheet.getRangeByName('G${i + 2}').setText(records[i].time);
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final String path = (await getApplicationDocumentsDirectory()).path;

    var fileName = '$path/${docName.text}.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    Get.back();
    await comnnts.progressDialog();

    OpenFile.open(fileName);
  }

  void isValidate() {
    if (formkey.currentState!.validate()) {
      exelRecord();
    }
  }

  String? fileNameValidation(value) {
    if (value.replaceAll(new RegExp(r"\s+"), "").length < 3) {
      return "File name must be 3 characters long";
    } else {
      return null;
    }
  }
  void getTimeAndDate() {
    final DateTime now = DateTime.now();
    nowTime.value = DateFormat('hh:mm:ss a').format(now);
    date.value = Components().getDate();
  }

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
    getTimeAndDate();
    // TODO: implement onInit
    super.onInit();
  }
}
