import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
}

class ButtonController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
