

import 'package:get/get.dart';
import 'package:sibzamini/controller/detail/detail_controller.dart';

class DetailBiding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<DetailController>(DetailController());
  }

}