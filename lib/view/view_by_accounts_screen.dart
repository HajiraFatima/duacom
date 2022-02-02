import 'package:duas/controller/view_by_accounts_controller.dart';
import 'package:duas/models/dashboard_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewByAccountsScreen extends GetView<ViewByAccountsController> {
  const ViewByAccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Container(height: Get.height, width: Get.width, child: Text('sadasdsad')),
      Container(
        height: Get.height * 0.25,
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
            margin:
                EdgeInsets.only(left: Get.width * 0.1, top: Get.height * 0.03),
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

        ],
      ),
              Positioned(
                  top: Get.height*0.16,
                  width: Get.width*1,
                  child: searchByNumberOrName()),
      Positioned(
          top: Get.height * 0.25,
          child: SizedBox(
            height: Get.height * 0.6,
            width: Get.width,
            child: Obx(
              () => controller.recents10Records.isNotEmpty? ListView(
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
                  return Card(
                    elevation: 10,

                    child: GestureDetector(
                   onTap: (){
                     singleRecord(i,picName,clr);
                   },
                      child: ListTile(
                        isThreeLine: true,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("TrxId : ${i.trxId}"),
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
                      style: const TextStyle(
                          color: Colors.black, fontSize: 20),
                    )),
                  ))
                ],
              )
            ),
          ))
    ])));
  }

  Widget searchByNumberOrName(){
    return Form(
      key: controller.formkey,
      child: Row(
        children: [
           Expanded(flex: 8,
          child:  Container(
            margin: EdgeInsets.only(left: Get.width*0.11),
            child:  TextFormField(
              controller: controller.searchByValue,
              validator: controller.searchValidation,
              style: TextStyle(color: Colors.blue),
              decoration: const InputDecoration(
                hintText: 'Search By No or Name',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.blue)) ,
                border:  OutlineInputBorder(
                    borderSide:  BorderSide(color: Colors.blue)),
              ),
            ),
          ),
          ),
          Expanded(flex: 2,
          child: IconButton(
              onPressed: (){
                controller.validate();
              },
             icon:Icon(Icons.search,color: Colors.white,size: 25,)),
          ),

        ],
      ),
    );
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
}
