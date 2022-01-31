import 'package:duas/controller/splash_screen_controller.dart';
import 'package:duas/routemanagement/screen_bindings.dart';
import 'package:duas/routemanagement/set_routes.dart';
import 'package:duas/view/bottom_navi_bar.dart';
import 'package:duas/view/dashboard_screen.dart';
import 'package:duas/view/drawer_screen.dart';
import 'package:duas/view/exel_files_screen.dart';
import 'package:duas/view/history_screen.dart';
import 'package:duas/view/home.dart';
import 'package:duas/view/login_screen.dart';
import 'package:duas/view/recent_screen.dart';
import 'package:duas/view/splash_screen.dart';
import 'package:duas/view/view_by_accounts_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AllPages {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: rLoginScreen,
          page: () => const LoginScreen(),
          binding: ScreenBinding()),
      GetPage(
          name: rDashboard,
          page: () => const DashboardScreen(),
          binding: ScreenBinding()),
      GetPage(
          name: rRecent,
          page: () => const RecentScreen(),
          binding: ScreenBinding()),
      GetPage(
          name: rHistory,
          page: () => const HistoryScreen(),
          binding: ScreenBinding()),
      GetPage(
          name: rBottomNavyBar,
          page: () => const BottomNavyBarScreen(),
          binding: ScreenBinding()),
      GetPage(
          name: rDrawer,
          page: () => const DrawerScreen(),
          binding: ScreenBinding()),
      GetPage(
          name: rHomeScreen,
          page: () => const HomeScreen(),
          binding: ScreenBinding()),
      GetPage(
          name: rViewByAccounts,
          page: () => const ViewByAccountsScreen(),
          binding: ScreenBinding()),
      GetPage(
          name: rExelScreen,
          page: () => const ExelFilesScreen(),
          binding: ScreenBinding()),
      GetPage(
          name: rSplashScreen,
          page: () =>  SplashScreen(),
          binding: ScreenBinding()),
    ];
  }
}
