import 'package:get/get.dart';
import 'package:sibzamini/controller/splash/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashScreenController>(SplashScreenController());
  }
}
