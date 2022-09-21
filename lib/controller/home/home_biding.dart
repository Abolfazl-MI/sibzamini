import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:sibzamini/controller/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<HomeController>(HomeController());
  }
}
