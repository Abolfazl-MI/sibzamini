
import 'package:get/get.dart';

class DetailController extends GetxController{

  int selectedIndex=0;

  void updateSelectedIndex(int newValue){
    selectedIndex=newValue;
    update();
  }
}