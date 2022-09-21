import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeController extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }
}
