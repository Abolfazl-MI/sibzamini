

import 'package:get/get.dart';
import 'package:sibzamini/controller/all_salons_controller/all_salons_controller.dart';

class AllSalonsBinding implements Bindings{
  @override
  void dependencies() {
      Get.put<AllSalonsController>(AllSalonsController());
  }

}