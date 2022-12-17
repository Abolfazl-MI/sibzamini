import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/models/comment_model/comment_model.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/models/services_model/services_model.dart';
import 'package:sibzamini/services/local/shared_service.dart';
import 'package:sibzamini/services/remote/api_services.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';
import 'package:url_launcher/url_launcher.dart';
class DetailController extends GetxController {
  // dependcies
  final ApiServices _apiServices = ApiServices();
  final SharedStorageService _storageService=SharedStorageService();
  // vaiables
  int selectedIndex = 0;
  Salon? salonDetail;
  double rateToSalon = 0;
  bool isLoading = false;
  bool isCommentLoading=false;
  Salon? salondetail;
  List<Comment>? salonComments;
  List<SalonService>? salonServices;
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

  Future<void> _getSalonDeatail({required int id}) async {
    DataState<Salon> salonDetailResult =
        await _apiServices.getSalonDetail(id: id);
    if (salonDetailResult is DataSuccesState) {
      salonDetail = salonDetailResult.data;
      update();
    }
    if (salonDetailResult is DataFailState) {
      Get.offNamed(rErrorScreen,
          arguments: {'error': salonDetailResult.error});
    }
  }

  Future<void> _getSalonComments({required int id}) async {
    DataState<List<Comment>> results =
        await _apiServices.getSalonComments(id: id);
    if (results is DataSuccesState) {
      salonComments=results.data;
      update();
    }
    if (results is DataFailState) {
      // handle the error
      salonComments=[];
      update();
    }
  }
  Future<void> _getSalonServices({required int id})async{
    DataState<List<SalonService>> result= await _apiServices.getSingleSalonServices(salonId: id);
    if(result is DataSuccesState){
      salonServices=result.data;
      update();
    }
    if(result is DataFailState){
      salonServices=[];
      update();
    }

  }

  Future<void>getSalonDetail({required int id})async{
    log('============fetching slon details============');
    isLoading=true;
    update();
    await _getSalonDeatail(id: id);
    await _getSalonServices(id: id);
    await _getSalonComments(id: id);
    isLoading=false;
    update();
  }

  getOpinionBasedRatingCount(int rate) {
    if (rate == 1) {
      return 'بد';
    } else if (rate == 2) {
      return 'ضعیف';
    } else if (rate == 3) {
      return 'متوسط';
    } else if (rate == 4) {
      return 'خوب';
    } else if (rate == 5) {
      return 'عالی';
    }
  }

  // sends user comment for coresponding salon 
  Future<void>sendComment({required String comment, required int rate,})async{
    String? usertToken=await _storageService.getuserToken();
    if(usertToken!=null){
      isCommentLoading=true;
      update();
      DataState<bool> result=await _apiServices.sendComment(salonId: salonDetail!.id!, userToken: usertToken, comment: comment, rate: rate);
      if(result is DataSuccesState){
        await _getSalonComments(id: salonDetail!.id!);
        isCommentLoading=false;
        update();
      }
      if(result is DataFailState){
        Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', result.error!,
          backgroundColor: Colors.red);
      }
    }
  }
  Future<void>addSalonToBookMarks()async{}
  Future<void>deleteSalonBookMark()async{}
  Future launchMApUrl(double lat,double lon )async{
    // String _url='https://www.google.com/maps/search/MM39%2BF63,+/@$lat,$lon,17z?hl=en';
    // if(!await launchUrl(lat, lon))
    final Uri url=Uri.parse('https://www.google.com/maps/search/MM39%2BF63,+/@$lat,$lon,17z?hl=en');
    if(!await launchUrl(url)){
      Get.snackbar('\u{1F610}' 'مشکلی پیش آمده','دوباره تلاشکنید ',
          backgroundColor: Colors.red);
    }
  }
  @override
  void onInit() {
    super.onInit();
    getSalonDetail(id: Get.arguments['id']);
  }
}
