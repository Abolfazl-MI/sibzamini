import 'package:get/get.dart';

class DetailController extends GetxController {
  int selectedIndex = 0;

  void updateSelectedIndex(int newValue) {
    selectedIndex = newValue;
    update();
  }

  double rateToSalon = 0;
  void updateRateForSalon(double newValue) {
    rateToSalon = newValue;
    update();
  }

  getOpinionBasedRatingCount() {
    if(rateToSalon==1){
        return 'بد';
    }else if(rateToSalon==2){
        return 'ضعیف';
    }else if(rateToSalon==3){
        return 'متوسط';
    }else if(rateToSalon==4){
        return 'خوب';

    }else if(rateToSalon==5){
        return 'عالی';
    }
    
     // switch (value) {
    //   case 1.0:
    //   case 2:
    //   case 3:

    //   case 4:
    //   case 5:
    // }

  }
}
