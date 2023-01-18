
import 'package:get/get.dart';
import 'package:sibzamini/controller/searchSalon/search_salon_controller.dart';
class SearchSalonBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<SearchSalonsController>(SearchSalonsController());
  }

}