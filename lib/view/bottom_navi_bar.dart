import 'package:duas/controller/bottom_navy_screen_controller.dart';
import 'package:duas/view/dashboard_screen.dart';
import 'package:duas/view/history_screen.dart';
import 'package:duas/view/recent_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BottomNavyBarScreen extends GetView<BottomNavyBarScreenController> {
  const BottomNavyBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          bottomNavigationBar:Obx(()=>bottomNavigationMenu()),
            body:Obx(()=> IndexedStack(
                index: controller.tabIndex.value,
              children: const [
                DashboardScreen(),
                RecentScreen(),
                HistoryScreen(),
              ],
              ),
            )));
  }

  bottomNavigationMenu(){
    return BottomNavigationBar(
      currentIndex: controller.tabIndex.value,
      onTap: controller.changeTabIndex,
      items: const [
       BottomNavigationBarItem(
         icon: Icon(Icons.home),
         label: '',
       ),
       BottomNavigationBarItem(
         icon: Icon(Icons.file_copy),
         label: '',
       ),
       BottomNavigationBarItem(
         icon: Icon(Icons.history),
         label: '',
       )

     ],
    );
  }
}
