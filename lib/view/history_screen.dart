// ignore_for_file: prefer_const_constructors

import 'package:duas/controller/history_screen_controller.dart';
import 'package:duas/custom/components.dart';
import 'package:duas/view/drawer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends GetView<HistoryScreenController> {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.download),
                onPressed: () {
                  if (controller.records.isNotEmpty) {
                    confirmDialog();
                  } else {
                    controller.comnnts.myToast('please fetch record first');
                  }
                }),
            // appBar: Components()
            //     .customAppBar(controller.screenName, Colors.blue[500]),
            // drawer: const DrawerScreen(),

            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: Get.height * 0.2,
                    width: Get.width,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color(0xff0a2141),
                      Color(0xff092b51),
                      Color(0xff084379),
                    ])),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Hello,',
                                  style: GoogleFonts.adventPro(
                                      textStyle: const TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ),
                              ),
                              Text('Dua',
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.adventPro(
                                      textStyle: const TextStyle(
                                          color: Colors.white, fontSize: 30))),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('Communications',
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.adventPro(
                                    textStyle: const TextStyle(
                                        color: Colors.white, fontSize: 30))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  selectDate(),
                  const Divider(),
                  Obx(() => controller.records.isNotEmpty
                      ? Container(
                          height: Get.height * 0.8,
                          child: ListView(
                            padding: const EdgeInsets.all(8.0),
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            children: controller.records.map((i) {
                              var picName = '';
                              if (i.selectedAccount == 'Jazz Cash') {
                                picName = 'jazzcash.jpg';
                              } else if (i.selectedAccount == 'Easy Paisa') {
                                picName = 'easypaisa.png';
                              } else if (i.selectedAccount == 'U Paisa') {
                                picName = 'upaisa.png';
                              } else if (i.selectedAccount == 'Omni') {
                                picName = 'omni.png';
                              } else if (i.selectedAccount == 'CNIC') {
                                picName = 'cnic.png';
                              }
                              return Card(
                                child: ListTile(
                                  title: Text(i.customerName),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                      'assets/${picName}',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  trailing: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Text(i
                                                .time)), // IconButton(icon:Icon(Icons.print),onPressed: (){},),
                                        Expanded(
                                            child: IconButton(
                                          icon: const Icon(Icons.print),
                                          onPressed: () {
                                            controller.tesPrint(i);
                                          },
                                        )),
                                      ]),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("TrxId : ${i.trxId}"),
                                      Text("MSISDN : ${i.msisdn} "),
                                      Text("Date : ${i.date}"),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : const Center(
                          child: Text(
                          "No Any Data",
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ))),
                ],
              ),
            )));
  }

  Widget selectDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDatePicker(Get.context, 'dateFrom');
            },
            child: Container(
              child: Center(
                  child: Obx(
                () => Text(
                  controller.dateFrom.value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              )),
              height: 50,
              width: Get.width * 0.3,
              decoration: BoxDecoration(
                  boxShadow: boxShadows(),
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              showDatePicker(Get.context, 'dateTo');
            },
            child: Container(
              width: Get.width * 0.3,
              child: Center(
                  child: Obx(
                () => Text(
                  controller.dateTo.value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              )),
              height: 50,
              decoration: BoxDecoration(
                boxShadow: boxShadows(),
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              controller.getRecordsByDate();
            },
            child: Container(
                child: const Center(
                  child: Icon(Icons.search),
                ),
                height: 50,
                width: Get.width * 0.3,
                decoration: BoxDecoration(
                    boxShadow: boxShadows(),
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      ),
    );
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

  void showDatePicker(context, dateBtn) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                // ignore: unnecessary_null_comparison
                if (value != null && dateBtn == 'dateFrom') {
                  controller.dateFrom.value = Components().getDate(date: value);
                  // ignore: unnecessary_null_comparison
                } else if (value != null && dateBtn == 'dateTo') {
                  controller.dateTo.value = Components().getDate(date: value);
                } else {
                  print('not slected');
                }
              },
              initialDateTime: DateTime.now(),
              minimumYear: 2019,
              maximumYear: 2030,
            ),
          );
        });
  }

  confirmDialog() {
    return Get.defaultDialog(
        title: "Enter file name",
        content: Column(
          children: [
            Form(
              key: controller.formkey,
              child: TextFormField(
                controller: controller.docName,
                validator: controller.fileNameValidation,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.values[7]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    controller.isValidate();
                  },
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.values[7]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
