import 'package:duas/controller/dashboard_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class Components {
  AppBar customAppBar(title, color) {
    return AppBar(
        elevation: 10,
        shadowColor: color,
        backgroundColor: color,
        toolbarHeight: 100,
        title: Text('$title',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )));
  }

  String getDate({date}) {
    var dateNow = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    var formatedDate = formatter.format(date ?? dateNow);
    return formatedDate;
  }

  final SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(
      context: Get.context, barrierDimisable: false);

  void showDialog(isDurationAllow, {title, error = false}) async {
    _dialog.show(
        message: isDurationAllow ? '' : 'Loading...',
        textStyle: const TextStyle(fontSize: 15, color: Colors.white),
        loadingIndicator: Text(
          '$title',
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
        backgroundColor: error ? Colors.red.shade200 : Colors.black,
        width: Get.width * 0.8,
        type: isDurationAllow
            ? SimpleFontelicoProgressDialogType.custom
            : SimpleFontelicoProgressDialogType.iphone);

    if (isDurationAllow) {
      await Future.delayed(const Duration(seconds: 1));
      _dialog.hide();
    }
  }

  List<BoxShadow> boxShadows() {
    return [
      BoxShadow(
          color: Colors.grey.shade300,
          spreadRadius: 0.0,
          blurRadius: 3.0,
          offset: Offset(3.0, 3.0)),
      BoxShadow(
          color: Colors.grey.shade400,
          spreadRadius: 0.0,
          blurRadius: 3.0 / 2.0,
          offset: const Offset(3.0, 3.0)),
      const BoxShadow(
          color: Colors.white,
          spreadRadius: 2.0,
          blurRadius: 3.0,
          offset: Offset(-3.0, -3.0)),
      const BoxShadow(
          color: Colors.white,
          spreadRadius: 2.0,
          blurRadius: 3.0 / 2,
          offset: Offset(-3.0, -3.0)),
    ];
  }

  Future<void> progressDialog() async {
    _dialog.show(
        message: '',
        textStyle: const TextStyle(fontSize: 15, color: Colors.white),
        backgroundColor: Colors.black,
        width: Get.width * 0.8,
        type: SimpleFontelicoProgressDialogType.iphone);

    await Future.delayed(const Duration(seconds: 1));
    _dialog.hide();
  }

  void hideDialog() {
    _dialog.hide();
  }

  myToast(title) {
    Fluttertoast.showToast(
      msg: "$title",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  confirmDialog() {
    return Get.defaultDialog(
        title: "",
        content: Column(
          children: [
            const Text(
              'Do you want to print this record?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      DashboardScreenController().tesPrint();
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  /////////////// DRAWER /////////////////////////

}
