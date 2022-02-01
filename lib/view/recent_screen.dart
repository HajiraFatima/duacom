import 'package:duas/controller/recents_screen_controller.dart';
import 'package:duas/custom/components.dart';
import 'package:duas/models/dashboard_screen_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'drawer_screen.dart';

class RecentScreen extends GetView<RecentScreenController> {
  const RecentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // appBar: Components()
            //     .customAppBar(controller.screenName, Colors.blue[500]),
            // drawer: const DrawerScreen(),

            body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(height: Get.height, width: Get.width, child: Text('')),
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
          Positioned(
            top: Get.height * 0.05,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
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
                ],
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.09,
            child: Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Text('Communications',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.adventPro(
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 30))),
            ),
          ),

          Positioned(
              top: Get.height * 0.22,
              right: Get.width * 0.05,
              child: IconButton(
                icon: Icon(Icons.search,   color: Colors.white),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate:SearchLocations()
                  );
                },
              )),
          Positioned(top: Get.height * 0.28, child: Divider()),
          Positioned(
            top: Get.height * 0.3,
            child: Container(
                height: Get.height * 0.7,
                width: Get.width,
                child: RefreshIndicator(
                    onRefresh: controller.getRecentRecords,
                    child: Obx(() => controller.recents10Records.isNotEmpty
                        ? ListView(
                            padding: const EdgeInsets.all(8.0),
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            children: controller.recents10Records.map((i) {

                              var picName = '';
                              if (i.selectedAccount == 'Jazz Cash') {
                                picName = 'jazzcash.jpg';
                              } else if (i.selectedAccount == 'Easy Paisa') {
                                picName = 'easypaisa.png';
                              } else if (i.selectedAccount == 'U Paisa') {
                                picName = 'upaisa.png';
                              } else if (i.selectedAccount == 'Omni') {
                                picName = 'omni.png';
                              } else if (i.selectedAccount == 'Post Paid Bill') {
                                picName = 'postpaid.png';
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
                                      i.selectedAccount=='Post Paid Bill'? Container():Text("TrxId : ${i.trxId}"),
                                      Text("MSISDN : ${i.msisdn} "),
                                      Text("Date : ${i.date}"),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ):ListView()))
            )
          ),
        ],
      ),
    )));
  }

  Widget searchField() {
    return Row(children: [
      TextField(
        controller: controller.search,
        onChanged: (value) {},
      ),
      Chip(label: Icon(Icons.close)),
    ]);
  }
}

class SearchLocations extends SearchDelegate{
  var controller = Get.put(RecentScreenController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = '';
        close(context, query);
      }, icon:Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return  IconButton(onPressed: (){
      query = '';
      close(context, query);
    }, icon:Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<DashboardModel> filteredRecord = controller.recents10Records
        .where((val) => val.msisdn.contains(query)).toList();
    return ListView.builder(
      itemCount: filteredRecord.length,
      itemBuilder: (BuildContext context, int index) {
        var picName = '';
        if (filteredRecord[index].selectedAccount == 'Jazz Cash') {
          picName = 'jazzcash.jpg';
        } else if (filteredRecord[index].selectedAccount == 'Easy Paisa') {
          picName = 'easypaisa.png';
        } else if (filteredRecord[index].selectedAccount == 'U Paisa') {
          picName = 'upaisa.png';
        } else if (filteredRecord[index].selectedAccount == 'Omni') {
          picName = 'omni.png';
        } else if (filteredRecord[index].selectedAccount == 'Post Paid Bill') {
          picName = 'postpaid.png';
        }

        return Card(
          child: ListTile(
            title: Text(filteredRecord[index].customerName),
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'assets/$picName}',
                fit: BoxFit.fitHeight,
              ),
            ),
            trailing: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(filteredRecord[index].time)),
                  Expanded(
                      child: IconButton(
                        icon: const Icon(Icons.print),
                        onPressed: () {
                          controller.tesPrint(filteredRecord[index]);
                        },
                      )),
                ]),
            subtitle: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                filteredRecord[index].trxId==''?Text(''):Text("TrxId : ${filteredRecord[index].trxId}"),
                Text("MSISDN : ${filteredRecord[index].msisdn} "),
                Text("Date : ${filteredRecord[index].date}"),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final List<DashboardModel> filteredRecord = controller.recents10Records
        .where((val) => val.msisdn.contains(query)).toList();
    return ListView.builder(
      itemCount: filteredRecord.length,
      itemBuilder: (BuildContext context, int index) {
        var picName = '';
        if (filteredRecord[index].selectedAccount == 'Jazz Cash') {
          picName = 'jazzcash.jpg';
        } else if (filteredRecord[index].selectedAccount == 'Easy Paisa') {
          picName = 'easypaisa.png';
        } else if (filteredRecord[index].selectedAccount == 'U Paisa') {
          picName = 'upaisa.png';
        } else if (filteredRecord[index].selectedAccount == 'Omni') {
          picName = 'omni.png';
        } else if (filteredRecord[index].selectedAccount == 'Post Paid Bill') {
          picName = 'postpaid.png';
        }
        return Card(
          child: ListTile(
            title: Text(filteredRecord[index].customerName),
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'assets/$picName',
                fit: BoxFit.fitHeight,
              ),
            ),
            trailing: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(filteredRecord[index].time)),
                  // IconButton(icon:Icon(Icons.print),onPressed: (){},),
                  Expanded(
                      child: IconButton(
                        icon: const Icon(Icons.print),
                        onPressed: () {
                          controller.tesPrint(filteredRecord[index]);
                        },
                      )),
                ]),
            subtitle: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                filteredRecord[index].trxId==''?Text(''):Text("TrxId : ${filteredRecord[index].trxId}"),
                Text("MSISDN : ${filteredRecord[index].msisdn} "),
                Text("Date : ${filteredRecord[index].date}"),
              ],
            ),
          ),
        );
      },
    );

  }

}