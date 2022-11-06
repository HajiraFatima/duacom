import 'dart:convert' as convert;

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:duas/custom/components.dart';
import 'package:duas/custom/ip_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreenController extends GetxController {
  String screenName = '';
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  RxList<BluetoothDevice> _devices = RxList<BluetoothDevice>();
  Components comnnts = Components();
  TextEditingController addLine = TextEditingController();
  var url = Uri.parse('http://$kPrimaryId/duas_php_files/last_line.php');
  var line = Uri.parse('http://$kPrimaryId/duas_php_files/view_line.php');

  var device;
  RxString selectedDevice = 'MTP-2'.obs;
  RxBool connected = false.obs;
  RxBool isOn = false.obs;

  @override
  void onInit() {
    getLastLine();
    getConnectionWithBluetooth();
    initPlatformState();

    super.onInit();
  }

  void getConnectionWithBluetooth() async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    connected.value = prfs.getBool('isConnected')!;
  }

  void getLastLine() async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    addLine.text = prfs.getString('lastLine')!;
    var isSet = prfs.getString('isSet')!;
    if (isSet == '1') {
      isOn.value = true;
    } else {
      isOn.value = false;
    }
  }

  Future<void> initPlatformState() async {
    List<BluetoothDevice> devices = [];
    try {
      _devices.value = await bluetooth.getBondedDevices();
      _devices.forEach((device) {
        if (device.name.toString() == 'MTP-2') {
          bluetooth.connect(device).catchError((error) {
            connect();
          });
        }
      });

      bluetooth.onStateChanged().listen((state) {
        switch (state) {
          case BlueThermalPrinter.CONNECTED:
            connected.value = true;

            break;
          case BlueThermalPrinter.DISCONNECTED:
            connected.value = false;

            break;
          default:
            break;
        }
      });
    } catch (error) {
      print(error);
    }
  }

  List<DropdownMenuItem<String>> getDeviceItems() {
    List<DropdownMenuItem<String>> items = [];

    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
        value: selectedDevice.value,
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name.toString()),
          value: device.name.toString(),
        ));
      });
    }
    return items;
  }

  void connect() {
    if (device == null) {
      comnnts.myToast("No device selected. or open the printer");
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected!) {
          bluetooth.connect(device).catchError((error) {
            connected.value = false;
            setConnectionWithBluetooth(false);
          });
        } else {
          connected.value = true;
          setConnectionWithBluetooth(true);
        }
      });
    }
  }

  void setConnectionWithBluetooth(value) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    prfs.setBool('isConnected', value);
  }

  void addLastLine() async {
    comnnts.showDialog(false);
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode({
            'line': addLine.text,
            'isSet': '',
          }));
      var result = convert.jsonDecode(response.body);
      if (result['result'] == 'true') {
        comnnts.hideDialog();
        comnnts.myToast("Line Successfully Added");
        await getLastLineRefresh();
      } else {
        comnnts.hideDialog();
        comnnts.myToast("ERROR...!");
      }
    } catch (er) {
      comnnts.hideDialog();
      comnnts.myToast("ERROR...!");
    }
  }

  void disconnect() {
    bluetooth.disconnect();
    connected.value = false;
  }

  Future<void> getLastLineRefresh() async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    var res = await http.get(line);
    var data = convert.jsonDecode(res.body);
    if (data['status'] == 'true') {
      prfs.setString('lastLine', data['result']['line']);
      prfs.setString('isSet', data['result']['isSet']);
    }
  }

  void onOff() async {
    comnnts.showDialog(false);
    try {
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode({
            'line': 'false',
            'isSet': isOn.value,
          }));
      var result = convert.jsonDecode(response.body);
      if (result['result'] == 'true') {
        comnnts.hideDialog();
        comnnts.myToast("State Set");
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
