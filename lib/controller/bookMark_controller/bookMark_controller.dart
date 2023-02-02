import 'package:get/get.dart';
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/services/remote/api_services.dart';
import 'package:sibzamini/services/local/shared_service.dart';
import 'package:sibzamini/models/bookmarked_salon_model/book_marked_salon_model.dart';

class BookMarkedSalonController extends GetxController {
  //dependncies
  final ApiServices _apiServices = ApiServices();
  final SharedStorageService _storageService = SharedStorageService();
  //variables
  bool isLoading = false;
  List<BookMarkedSalon> salons = [];
  //methods

  /// removes salon from favorites
  Future<void> deleteSalonFromFavorites(int salonIndex, int salonId) async {
    isLoading = true;
    update();
    String? token = await _storageService.getuserToken();
    if (token != null) {
      await _apiServices
          .deleteSalonFromBookMarkList(userToken: token, salonId: salonId)
          .then((DataState dataState) {
        if (dataState is DataSuccesState) {
          salons.removeAt(salonIndex);
          isLoading = false;
          update();
        } else {
          Get.snackbar('مشکلی پیش آمده',
              "خطا درانجام عملیات لطفا در زمان دیگر دوباره تلاش کنید");
        }
      });
    }
  }

  /// gets list of bookmarkedSalons
  Future<void> _getBookMarkedSalons() async {
    isLoading = true;
    update();
    String? token = await _storageService.getuserToken();
    if (token != null) {
      await _apiServices.getBookMarkedSalons(userToken: token).then(
        (DataState dataState) {
          if (dataState is DataSuccesState) {
            salons = dataState.data;
            isLoading = false;
            update();
          }
          if (dataState is DataFailState) {
            salons = [];
            isLoading = false;
            update();
          }
        },
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    _getBookMarkedSalons();
  }
}
