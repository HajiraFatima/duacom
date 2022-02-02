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
              top: Get.height * 0.16,
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
          Positioned(
              top: Get.height * 0.22,
              right: Get.width * 0.05,
              child:accountsDropDown()),
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
                              Color clr = Colors.blue;

                              if (i.selectedAccount == 'Jazz Cash') {
                                picName = 'jazzcash.jpg';
                                clr = Colors.orange;
                              } else if (i.selectedAccount == 'Easy Paisa') {
                                picName = 'easypaisa.png';
                                clr = Colors.green;
                              } else if (i.selectedAccount == 'U Paisa') {
                                picName = 'upaisa.png';
                                clr = Colors.blue;
                              } else if (i.selectedAccount == 'Omni') {
                                picName = 'omni.png';
                                clr = Colors.orange;
                              } else if (i.selectedAccount == 'Post Paid Bill') {
                                picName = 'postpaid.png';
                                clr = Colors.black;
                              }
                              return GestureDetector(
                                onTap: () {
                                  singleRecord(i,picName,clr);
                                },
                                child:Card(
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
                                ),
                              );
                            }).toList(),
                          ):ListView(
                      children: [
                        SizedBox(
                          height: Get.height*0.3,

                        ),
                        Obx(()=>Center(
                          child: (Text(controller.pleasewait.value,
                          style: TextStyle(
                          color: Colors.black, fontSize: 20),
                          )),
                        ))
                      ],
                    )))
            )
          ),
        ],
      ),
    )));
  }
  singleRecord(DashboardModel model,img,clr) {

    if(model.selectedAccount == 'Post Paid Bill'){
      return Get.defaultDialog(
          title: "${model.customerName}",
          content: Column(
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
                            'assets/$img')),
                    borderRadius:
                    BorderRadius
                        .circular(100),
                    border: Border.all(
                      color: clr,
                      width: 3,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              dataRow('MSISDN : ', model.msisdn),
              const Divider(),
              dataRow('ACCOUNT : ', model.selectedAccount),
              const Divider(),
              dataRow('NETWORK : ', model.network),
              const Divider(),
              dataRow('AMOUNT : ', model.amount),
              const Divider(),
              dataRow('DATE : ', model.date),
              const Divider(),
              dataRow('TIME : ', model.time),
            ],
          ));
    }else{
      return Get.defaultDialog(
          title: "${model.customerName}",
          content: Column(
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
                            'assets/$img')),
                    borderRadius:
                    BorderRadius
                        .circular(100),
                    border: Border.all(
                      color: clr,
                      width: 3,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(),
              dataRow('MSISDN : ', model.msisdn),
              Divider(),
              dataRow('ACCOUNT : ', model.selectedAccount),
              Divider(),
              dataRow('AMOUNT : ', model.amount),
              Divider(),
              dataRow('TRXID : ', model.trxId),
              Divider(),
              dataRow('DATE : ', model.date),
              Divider(),
              dataRow('TIME : ', model.time),
            ],
          ));
    }
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


  Widget accountsDropDown() {
    return  SizedBox(
      width: Get.width*0.9,
      height: 50,
      child: Obx(
            () => DecoratedBox(
              decoration:const BoxDecoration(
                color:Colors.white30,
              ),
              child: DropdownButton(


               iconEnabledColor: Colors.white,
                underline: const SizedBox(),
                isExpanded: true,
                value: controller.selectedAccount.value,
                items: controller.getItems(),
                onChanged: (value) {
                  controller.selectedAccount.value = value.toString();
                  controller.getRecentRecordsByAccount();
          },
        ),
            ),
      ),
    );
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
    List<DashboardModel> filteredRecord = [];



    if(controller.recents10Records
        .where((val) => val.msisdn.contains(query)).isNotEmpty){

      filteredRecord = controller.recents10Records
          .where((val) => val.msisdn.contains(query)).toList();
    }
    if(controller.recents10Records
        .where((val) => val.customerName.toLowerCase().contains(query.toLowerCase())).isNotEmpty){
      filteredRecord = controller.recents10Records
          .where((val) => val.customerName.toLowerCase().contains(query.toLowerCase())).toList();
    }
    return suggestions(filteredRecord);

  }

  @override
  Widget buildSuggestions(BuildContext context) {

     List<DashboardModel> filteredRecord = [];


     if(controller.recents10Records
         .where((val) => val.msisdn.contains(query)).isNotEmpty){
       filteredRecord = controller.recents10Records
           .where((val) => val.msisdn.contains(query)).toList();
     }
     if(controller.recents10Records
         .where((val) => val.customerName.toLowerCase().contains(query.toLowerCase())).isNotEmpty){
       filteredRecord = controller.recents10Records
           .where((val) => val.customerName.toLowerCase().contains(query.toLowerCase())).toList();
     }
    return suggestions(filteredRecord);

  }

  Widget suggestions(List<DashboardModel> filteredRecord){
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