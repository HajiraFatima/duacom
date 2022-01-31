import 'package:duas/controller/bottom_navy_screen_controller.dart';
import 'package:duas/controller/dashboard_screen_controller.dart';
import 'package:duas/controller/drawer_screen_controller.dart';
import 'package:duas/controller/exel_files_screen_controller.dart';
import 'package:duas/controller/history_screen_controller.dart';
import 'package:duas/controller/home_screen_controller.dart';
import 'package:duas/controller/login_screen_controller.dart';
import 'package:duas/controller/recents_screen_controller.dart';
import 'package:duas/controller/splash_screen_controller.dart';
import 'package:duas/controller/view_by_accounts_controller.dart';
import 'package:duas/view/view_by_accounts_screen.dart';
import 'package:get/get.dart';

class ScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginScreenController());
    Get.lazyPut(() => DashboardScreenController());
    Get.lazyPut(() => RecentScreenController());
    Get.lazyPut(() => HistoryScreenController());
    Get.lazyPut(() => BottomNavyBarScreenController());
    Get.lazyPut(() => DrawerScreenController());
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => ViewByAccountsController());
    Get.lazyPut(() => ExelFilesScreenController());
    Get.lazyPut(() => SplashScreenController());

    // TODO: implement dependencies
  }
}
