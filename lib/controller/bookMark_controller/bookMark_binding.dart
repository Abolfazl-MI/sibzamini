
import 'package:get/get.dart';
import 'package:sibzamini/controller/bookMark_controller/bookMark_controller.dart';

class BookMarkedSalonsBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<BookMarkedSalonController>(BookMarkedSalonController());
  }

}