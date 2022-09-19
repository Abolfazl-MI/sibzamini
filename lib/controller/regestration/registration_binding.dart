import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:sibzamini/controller/controller.dart';

class RegistrationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RegistrationController>(RegistrationController());
  }
}
