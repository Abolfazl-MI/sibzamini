import 'package:get/get.dart';
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/models/comment_model/comment_model.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/services/remote/api_services.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';

class DetailController extends GetxController {
  // dependcies
  final ApiServices _apiServices = ApiServices();

  // vaiables
  int selectedIndex = 0;
  Salon? salonDetail;
  double rateToSalon = 0;
  bool isLoading = false;
  Salon? salondetail;
  List<Comment>? salonComments;
  // methods
  // bottom navigation
  void updateSelectedIndex(int newValue) {
    selectedIndex = newValue;
    update();
  }

  // update rate
  void updateRateForSalon(double newValue) {
    rateToSalon = newValue;
    update();
  }

  Future<void> salonDeatail({required int id}) async {
    DataState<Salon> salonDetailResult =
        await _apiServices.getSalonDetail(id: id);
    if (salonDetailResult is DataSuccesState) {
      salonDetail = salonDetailResult.data;
      update();
    }
    if (salonDetailResult is DataFailState) {
      Get.offNamed(rErrorScreen,
          arguments: {'detail_error': salonDetailResult.error});
    }
  }

  Future<void> getSalonComments({required int id}) async {
    DataState<List<Comment>> results =
        await _apiServices.getSalonComments(id: id);
    if (results is DataSuccesState) {
      salonComments=results.data;
      update();
    }
    if (results is DataFailState) {
      // handle the error
    }
  }

  getOpinionBasedRatingCount() {
    if (rateToSalon == 1) {
      return 'بد';
    } else if (rateToSalon == 2) {
      return 'ضعیف';
    } else if (rateToSalon == 3) {
      return 'متوسط';
    } else if (rateToSalon == 4) {
      return 'خوب';
    } else if (rateToSalon == 5) {
      return 'عالی';
    }
  }
}
