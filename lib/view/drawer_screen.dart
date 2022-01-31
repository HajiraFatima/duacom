import 'package:duas/controller/drawer_screen_controller.dart';
import 'package:duas/routemanagement/set_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerScreen extends GetView<DrawerScreenController> {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(controller.screenName),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(
                      () => DropdownButton(
                          items: controller.getDeviceItems(),
                          value: controller.selectedDevice.value,
                          onChanged: (value) {
                            controller.selectedDevice.value = value.toString();
                          }),
                    ),
                    Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: controller.connected.value
                                ? Colors.red
                                : Colors.green),
                        onPressed: () {
                          controller.connected.value
                              ? controller.disconnect()
                              : controller.connect();
                        },
                        child: Obx(
                          () => Text(
                            controller.connected.value
                                ? 'Disconnect'
                                : 'Connect',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(rExelScreen);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.purple.shade100,
                    Colors.purple.shade100,
                  ])),
                  child: const ListTile(
                    leading: Icon(Icons.folder),
                    title: Text('Exel Files'),
                  ),
                ),
              ),
              const Divider(),
              // GestureDetector(
              //   onTap: () {
              //     controller.isOn.value = !controller.isOn.value;
              //     controller.onOff();
              //   },
              //   child: Obx(
              //     () => Container(
              //       margin: const EdgeInsets.symmetric(horizontal: 10),
              //       height: 50,
              //       width: Get.width,
              //       decoration: BoxDecoration(
              //           gradient: controller.isOn.value
              //               ? LinearGradient(colors: [
              //                   Colors.purple.shade100,
              //                   Colors.purple.shade100,
              //                 ])
              //               : LinearGradient(colors: [
              //                   Colors.grey.shade100,
              //                   Colors.grey.shade100,
              //                 ])),
              //       child: Obx(
              //         () => ListTile(
              //           leading: controller.isOn.value
              //               ? const Icon(Icons.lightbulb, color: Colors.yellow)
              //               : const Icon(
              //                   Icons.lightbulb,
              //                   color: Colors.grey,
              //                 ),
              //           title: controller.isOn.value
              //               ? const Text('ON')
              //               : const Text('OFF'),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              const Divider(),
              Column(
                children: [
                  Divider(),
                  Container(
                    width: Get.width * 0.8,
                    child: TextFormField(
                      controller: controller.addLine,
                      decoration: InputDecoration(
                          hintText: 'Add Last Line',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addLastLine();
                    },
                    child: Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.values[7]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
