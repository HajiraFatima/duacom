import 'dart:convert' as convert;

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:duas/custom/components.dart';
import 'package:duas/models/dashboard_screen_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom/ip_settings.dart';

class DashboardScreenController extends GetxController {
  TextEditingController msisdn = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController amount2 = TextEditingController();
  TextEditingController trxId = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  RxList<DashboardModel> datas = RxList<DashboardModel>();

  var url = Uri.parse('http://$kPrimaryId/duas_php_files/duas/');
  var last_record =
      Uri.parse('http://$kPrimaryId/duas_php_files/last_record.php');

  Components comnnts = Components();
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  RxList<BluetoothDevice> _devices = RxList<BluetoothDevice>();
  var data;
  var device;
  RxBool connected = false.obs;
  RxString selectedAccount = 'Easy Paisa'.obs;
  RxString selectedPost = 'Jazz'.obs;
  RxString date = ''.obs;
  RxString nowTime = ''.obs;

  List<String> accountTypesList = [
    'Jazz Cash',
    'Easy Paisa',
    'U Paisa',
    'Omni',
    'Post Paid Bill'
  ];

  List<String> postPaidAccountTypesList = [
    'Jazz',
    'Telenor',
    'Ufone',
    'Zong',
  ];

  List accountTypesImages = [
    'jazzcash.jpg',
    'easypaisa.png',
    'upaisa.png',
    'omni.png',
    'postpaid.png'
  ];
  List postPaidccountsImages = [
    'jazzSim.png',
    'telenorSim.png',
    'ufoneSim.png',
    'zongSim.png',
  ];

  //the birthday's date
  validate2() async {
    if (formkey2.currentState!.validate()) {
      comnnts.showDialog(false);
      String date = Components().getDate();
      String time = getTime();
      // int parsedAmount = int.parse(amount.text);
      data = DashboardModel(
        selectedAccount: selectedAccount.value,
        msisdn: msisdn.text,
        customerName: customerName.text,
        amount: amount.text,
        trxId: trxId.text,
        date: date,
        time: time,
        network: selectedPost.value,
      );
      try {
        var response = await http.post(url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: convert.jsonEncode(data));
        var result = convert.jsonDecode(response.body);
        if (result['result'] == 'true') {
          comnnts.hideDialog();
          comnnts.myToast("Record Successfully Added");
          comnnts.confirmDialog();
        } else {
          comnnts.hideDialog();
          comnnts.myToast("ERROR...!");
        }
      } catch (er) {
        comnnts.hideDialog();
        comnnts.myToast("ERROR...!");
      }
    } else {
      print(false);
    }
  }

  void checkTime() {
    String time = getTime();
    print(time);
  }

  addData() async {
    if (formkey.currentState!.validate()) {
      comnnts.showDialog(false);
      String date = Components().getDate();
      String time = getTime();
      // int parsedAmount = int.parse(amount.text);
      data = DashboardModel(
        selectedAccount: selectedAccount.value,
        msisdn: msisdn.text,
        customerName: customerName.text,
        amount: amount.text,
        trxId: trxId.text,
        date: date,
        time: time,
        network: '',
      );
      try {
        var response = await http.post(url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: convert.jsonEncode(data));
        var result = convert.jsonDecode(response.body);
        if (result['result'] == 'true') {
          comnnts.hideDialog();
          comnnts.myToast("Record Successfully Added");

          // msisdn.clear();
          // customerName.clear();
          // amount.clear();
          // trxId.clear();
          //

          comnnts.confirmDialog();
        } else {
          comnnts.hideDialog();
          comnnts.myToast("ERROR...!");
        }
      } catch (er) {
        comnnts.hideDialog();
        comnnts.myToast("ERROR...!");
      }
    }
  }

  @override
  void onInit() {
    getItems();
    getTimeAndDate();
    initPlatformState();

    super.onInit();
  }

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

  List<DropdownMenuItem<String>> getpostPaidItems() {
    List<DropdownMenuItem<String>> items = [];

    for (int i = 0; i < postPaidAccountTypesList.length; i++) {
      items.add(DropdownMenuItem(
        child: Container(
          height: 50,
          child: ListTile(
            leading: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.white,
                child: Image.asset('assets/${postPaidccountsImages[i]}')),
            title: Text(postPaidAccountTypesList[i]),
          ),
        ),
        value: postPaidAccountTypesList[i],
      ));
    }

    return items;
  }

  Future<void> initPlatformState() async {
    List<BluetoothDevice> devices = [];
    try {
      _devices.value = await bluetooth.getBondedDevices();
      _devices.forEach((device) {
        if (device.name.toString() == 'MTP-2') {
          bluetooth.connect(device).catchError((error) {
            bluetooth.isConnected.then((isConnected) {
              if (!isConnected!) {
                bluetooth.connect(device).catchError((error) {
                  setConnectionWithBluetooth(false);
                });
              } else {
                setConnectionWithBluetooth(true);
              }
            });
          });
        }
      });
    } catch (error) {}
  }

  void setConnectionWithBluetooth(val) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    prfs.setBool('isConnected', val);
  }

  void getTimeAndDate() {
    final DateTime now = DateTime.now();
    nowTime.value = DateFormat('hh:mm:ss a').format(now);
    date.value = Components().getDate();
  }

  void tesPrint() async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    String line = prfs.getString('lastLine')!;
    var res = await http.get(last_record);
    var rec = convert.jsonDecode(res.body);

    for (var fetch in data['data']) {
      datas.add(DashboardModel.fromJson(fetch));
    }

    Get.back();
    bluetooth.isConnected.then((isConnected) {
      // if (isConnected == true) {
      //   if (datas.selectedAccount == 'Post Paid Bill') {
      //     bluetooth.printCustom("--------------------------------", 0, 0);
      //     bluetooth.printCustom("DUA COMMUNICATION", 3, 1);
      //     bluetooth.printCustom("Oppst: Maryam marraige Hall near", 1, 1);
      //     bluetooth.printCustom("Zulfiqar Masjid Hirabad", 1, 1);
      //     bluetooth.printCustom("Contact:03033111126", 1, 1);
      //     bluetooth.printNewLine();
      //     bluetooth.printLeftRight("$nowTime", "$date", 0);
      //     bluetooth.printCustom("--------------------------------", 0, 0);
      //     bluetooth.printLeftRight("MSISDN", datas.msisdn, 0);
      //     bluetooth.printLeftRight("Account", datas.selectedAccount, 0);
      //     bluetooth.printLeftRight("Amount", datas.amount, 0);
      //     bluetooth.printCustom("--------------------------------", 1, 0);
      //     bluetooth.printCustom("Receipt Charges Rs.10/=", 1, 1);
      //     bluetooth.printCustom(line, 1, 1);
      //     bluetooth.printNewLine();
      //     bluetooth.printNewLine();
      //     bluetooth.paperCut();
      //   } else {
      //     bluetooth.printCustom("---------------------------------", 3, 0);
      //     bluetooth.printCustom("Dua  Communication", 5, 1);
      //     bluetooth.printNewLine();
      //     bluetooth.printCustom("Oppst: Maryam marraige Hall near", 3, 1);
      //     bluetooth.printCustom("Zulfiqar Masjid Hirabad", 3, 1);
      //     bluetooth.printCustom("Contact:03033111126", 3, 1);
      //     bluetooth.printNewLine();
      //     bluetooth.printLeftRight("time", "date", 0);
      //     bluetooth.printCustom("---------------------------------", 3, 0);
      //     bluetooth.printLeftRight("TrxID", datas.trxId, 0);
      //     bluetooth.printLeftRight("Name", datas.customerName, 0);
      //     bluetooth.printLeftRight("MSISDN", datas.msisdn, 0);
      //     bluetooth.printLeftRight("Account", datas.selectedAccount, 0);
      //     bluetooth.printLeftRight("Amount", datas.amount, 0);
      //     bluetooth.printCustom("---------------------------------", 3, 0);
      //     bluetooth.printCustom("Receipt Charges Rs.10/=", 3, 1);
      //     bluetooth.printCustom(line, 3, 1);
      //     bluetooth.printNewLine();
      //     bluetooth.printNewLine();
      //     bluetooth.paperCut();
      //   }
      // } else {
      //   comnnts.myToast("Please connect your printer!");
      // }
    });
  }

  void connectBluetooth() {}

  String getTime() {
    var timeNow = DateTime.now();
    var formatter = DateFormat('HH:mm:ss');
    var formatedDate = formatter.format(timeNow);
    var date =
        DateFormat.jm().format(DateFormat("hh:mm:ss").parse(formatedDate));

    return date;
  }

  String? msisdnValidation(value) {
    if (value.replaceAll(new RegExp(r"\s+"), "").length > 11 ||
        value.replaceAll(new RegExp(r"\s+"), "").length < 11) {
      return "msisdn must be 11 digits long";
    } else {
      return null;
    }
  }

  var msisdnFormatter = new MaskTextInputFormatter(
      mask: '###########',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  String? customerNameValidation(value) {
    if (value.replaceAll(new RegExp(r"\s+"), "").length < 3) {
      return "customer name must be at least 3 digits long";
    } else {
      return null;
    }
  }

  var customerNameFormatter = new MaskTextInputFormatter(
      mask: '',
      filter: {"#": RegExp(r'[a-z]')},
      type: MaskAutoCompletionType.lazy);

  var amountFormater = new MaskTextInputFormatter(
      mask: '#####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var amountFormater2 = new MaskTextInputFormatter(
      mask: '#####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  String? amountValidation(value) {
    if (value.replaceAll(new RegExp(r"\s+"), "").length < 2 ||
        value.replaceAll(new RegExp(r"\s+"), "").length > 5) {
      return "amount must be at least 5 digits long";
    } else {
      return null;
    }
  }

  String? amountValidation2(value) {
    if (value.replaceAll(new RegExp(r"\s+"), "").length < 2 ||
        value.replaceAll(new RegExp(r"\s+"), "").length > 5) {
      return "amount must be at least 5 digits long";
    } else {
      return null;
    }
  }

  var trxIdFormatter = new MaskTextInputFormatter(
      mask: '####################',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  String? trxIdValidation(value) {
    if (value.replaceAll(new RegExp(r"\s+"), "").length < 3) {
      return "trxId must be at least 3 digits long";
    } else {
      return null;
    }
  }
}
