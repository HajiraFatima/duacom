import 'package:duas/controller/home_screen_controller.dart';
import 'package:duas/models/dashboard_screen_model.dart';
import 'package:duas/routemanagement/set_routes.dart';
import 'package:duas/view/drawer_screen.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:analog_clock/analog_clock.dart';

import 'package:flutter/widgets.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: controller.scaffoldKey,
      drawerEnableOpenDragGesture: true,
      drawer: DrawerScreen(),
      body: Obx(
        () => controller.isScreenSet.value
            ? const Center(
                child: Text('Error...'),
              )
            : Stack(
                children: [
                  Container(
                      height: Get.height, width: Get.width, child: Text('')),
                  Container(
                    height: Get.height * 0.3,
                    width: Get.width,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color(0xff0a2141),
                      Color(0xff092b51),
                      Color(0xff084379),
                    ])),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: Get.width * 0.1, top: Get.height * 0.03),
                        child: Container(
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
                                              color: Colors.white,
                                              fontSize: 20)),
                                    ),
                                  ),
                                  Text('Dua',
                                      textAlign: TextAlign.justify,
                                      style: GoogleFonts.adventPro(
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30))),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text('Communications',
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.adventPro(
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30))),
                              ),
                              // Container(
                              //   alignment: Alignment.bottomLeft,
                              //   child: Text(controller.nowTime.value,
                              //       style: GoogleFonts.adventPro(
                              //           textStyle: const TextStyle(
                              //               color: Colors.blue, fontSize: 30))),
                              // ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: Get.height * 0.01,
                    left: Get.width * 0.7,
                    child: GestureDetector(
                      onTap: () {
                        controller.scaffoldKey.currentState!.openDrawer();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                        margin: const EdgeInsets.only(right: 20),
                        child: clock(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: Get.height * 0.18,
                    left: Get.width * 0.06,
                    child: Container(
                      height: Get.height * 0.3,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10, left: 10),
                                child: Text('Recents',
                                    style: GoogleFonts.adventPro(
                                        textStyle: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 25)))),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              height: Get.height * 0.2,
                              child: Obx(() => RefreshIndicator(
                                  triggerMode:
                                      RefreshIndicatorTriggerMode.anywhere,
                                  onRefresh: controller.getRecentRecords,
                                  child: controller.recents10Records.isNotEmpty
                                      ? ListView(
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.all(8.0),
                                          physics: const BouncingScrollPhysics(
                                              parent:
                                                  AlwaysScrollableScrollPhysics()),
                                          children: controller.recents10Records
                                              .map((i) {
                                            var picName = '';
                                            Color clr = Colors.blue;

                                            if (i.selectedAccount ==
                                                'Jazz Cash') {
                                              picName = 'jazzcash.jpg';
                                              clr = Colors.orange;
                                            } else if (i.selectedAccount ==
                                                'Easy Paisa') {
                                              picName = 'easypaisa.png';
                                              clr = Colors.green;
                                            } else if (i.selectedAccount ==
                                                'U Paisa') {
                                              picName = 'upaisa.png';
                                              clr = Colors.blue;
                                            } else if (i.selectedAccount ==
                                                'Omni') {
                                              picName = 'omni.png';
                                              clr = Colors.orange;
                                            } else if (i.selectedAccount ==
                                                'CNIC') {
                                              picName = 'cnic.png';
                                              clr = Colors.green;
                                            }
                                            return GestureDetector(
                                              onTap: () {
                                                singleRecord(i);
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 4),
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                'assets/${picName}')),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        border: Border.all(
                                                          color: clr,
                                                          width: 3,
                                                        )),
                                                  ),
                                                  Container(
                                                      margin: const EdgeInsets
                                                              .only(
                                                          top: 10, left: 10),
                                                      child: Text(i.msisdn,
                                                          style: GoogleFonts.adventPro(
                                                              textStyle:
                                                                  const TextStyle(
                                                                      color: Colors
                                                                          .blue,
                                                                      fontSize:
                                                                          15)))),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        )
                                      : ListView())),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(rRecent);
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Text('view All',
                                      style: GoogleFonts.adventPro(
                                          textStyle: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15)))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: Get.height * 0.5,
                    left: Get.width * 0.06,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(rDashboard);
                      },
                      child: Container(
                        height: Get.height * 0.2,
                        width: Get.width * 0.42,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                child: Image.asset('assets/mobile.png')),
                            Text(
                              'Add Record,',
                              style: GoogleFonts.adventPro(
                                  textStyle: const TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.8),
                              offset: Offset(-6.0, -6.0),
                              blurRadius: 16.0,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(6.0, 6.0),
                              blurRadius: 16.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: Get.height * 0.5,
                    left: Get.width * 0.52,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(rHistory);
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                child: Image.asset(
                                  'assets/history.png',
                                  color: Color(0xff084379),
                                )),
                            Text(
                              'Search',
                              style: GoogleFonts.adventPro(
                                  textStyle: const TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                          ],
                        ),
                        height: Get.height * 0.2,
                        width: Get.width * 0.42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.8),
                              offset: Offset(-6.0, -6.0),
                              blurRadius: 16.0,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(6.0, 6.0),
                              blurRadius: 16.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: Get.height * 0.72,
                      left: Get.width * 0.01,
                      child: Container(
                        height: Get.height * 0.2,
                        width: Get.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(rViewByAccounts,
                                      arguments: 'Easy Paisa');
                                },
                                child: bottomContainer('e.png', 'Easy Paisa')),
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(rViewByAccounts,
                                      arguments: 'Jazz Cash');
                                },
                                child:
                                    bottomContainer('jazz.png', 'Jazz Cash')),
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(rViewByAccounts,
                                      arguments: 'Omni');
                                },
                                child: bottomContainer('omni.png', 'Omni')),
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(rViewByAccounts,
                                      arguments: 'U Paisa');
                                },
                                child:
                                    bottomContainer('upaisa.png', 'U Paisa')),
                          ],
                        ),
                      ))
                ],
              ),
      ),
    ));
  }

  Widget bottomContainer(img, title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        height: Get.height * 0.2,
        width: Get.width * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              offset: const Offset(-6.0, -6.0),
              blurRadius: 16.0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(6.0, 6.0),
              blurRadius: 16.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 100,
                width: 100,
                child: Image.asset(
                  'assets/${img}',
                )),
            Text(
              title,
              style: GoogleFonts.adventPro(
                  textStyle:
                      const TextStyle(color: Colors.black, fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}

singleRecord(DashboardModel model) {
  return Get.defaultDialog(
      title: "${model.customerName}",
      content: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          dataRow('msisdn : ', model.msisdn),
          dataRow('account : ', model.selectedAccount),
          dataRow('amount : ', model.amount),
          dataRow('trxID : ', model.trxId),
          dataRow('date : ', model.date),
          dataRow('time : ', model.time),
        ],
      ));
}

Widget clock() {
  return AnalogClock(
    decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.blue),
        color: Colors.black,
        shape: BoxShape.circle),
    width: 150.0,
    isLive: true,
    useMilitaryTime: true,
    showAllNumbers: true,
    hourHandColor: Colors.blue,
    minuteHandColor: Colors.blue,
    showSecondHand: true,
    numberColor: Colors.blue,
    showNumbers: true,
    textScaleFactor: 1.8,
    showTicks: true,
    tickColor: Colors.white,
    digitalClockColor: Colors.blue,
    secondHandColor: Colors.blue,
    showDigitalClock: true,
    datetime: DateTime(2019, 1, 1, 9, 12, 15),
  );
}

Widget dataRow(title, text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
          flex: 5,
          child: Container(
            child: Text(title),
          )),
      Expanded(
          flex: 5,
          child: Container(
            child: Text(text),
          )),
    ],
  );
}