import 'package:get/get.dart';

class BottomNavyBarScreenController extends GetxController{
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }


}