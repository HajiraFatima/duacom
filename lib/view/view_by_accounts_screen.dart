import 'package:duas/controller/view_by_accounts_controller.dart';
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
        height: Get.height * 0.2,
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
          top: Get.height * 0.2,
          child: SizedBox(
            height: Get.height * 0.8,
            width: Get.width,
            child: Obx(
              () => ListView(
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
                  } else if (i.selectedAccount == 'CNIC') {
                    picName = 'cnic.png';
                  }
                  return Card(
                    elevation: 10,
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
                  );
                }).toList(),
              ),
            ),
          ))
    ])));
  }
}
