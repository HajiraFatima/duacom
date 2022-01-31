import 'package:duas/controller/exel_files_screen_controller.dart';
import 'package:duas/controller/view_by_accounts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExelFilesScreen extends GetView<ExelFilesScreenController> {
  const ExelFilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Container(
          height: Get.height,
          width: Get.width,
          child: Text(controller.screenName)),
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'All,',
                      style: GoogleFonts.adventPro(
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Exel Files',
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
              children: controller.files.map((i) {
                var name = i
                    .toString()
                    .split('/data/user/0/com.example.duas/app_flutter/');
                var filename = name[1].split("'")[0];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.openFile(i.toString().split('File: ')[1]);
                      },
                      child: ListTile(
                        title: Text(filename),
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            'assets/exel.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      )
    ])));
  }
}
