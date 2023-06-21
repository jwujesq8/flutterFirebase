import 'package:get/get.dart';

class HomeAppController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.offAllNamed('/library');
        break;
      case 1:
        Get.offAllNamed('/home');
        break;
      case 2:
        //TODO: something
        Get.offAllNamed('/cos');
        break;
    }
  }
}