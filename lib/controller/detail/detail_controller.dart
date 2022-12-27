import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/models/bookmarked_salon_model/book_marked_salon_model.dart';
import 'package:sibzamini/models/comment_model/comment_model.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/models/services_model/services_model.dart';
import 'package:sibzamini/services/local/shared_service.dart';
import 'package:sibzamini/services/remote/api_services.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class DetailController extends GetxController {
  // dependcies
  final ApiServices _apiServices = ApiServices();
  final SharedStorageService _storageService = SharedStorageService();
  // vaiables
  int selectedIndex = 0;
  Salon? salonDetail;
  double rateToSalon = 0;
  bool isLoading = false;
  bool isCommentLoading = false;
  bool isBookedMarked = false;
  Salon? salondetail;
  int ? salonId;
  List<Comment>? salonComments;
  List<SalonService>? salonServices;
  TextEditingController commentController = TextEditingController();

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
      Get.offNamed(rErrorScreen, arguments: {'error': salonDetailResult.error});
    }
  }

  Future<void> _getSalonComments({required int id}) async {
    DataState<List<Comment>> results =
        await _apiServices.getSalonComments(id: id);
    if (results is DataSuccesState) {
      salonComments = results.data;
      update();
    }
    if (results is DataFailState) {
      // handle the error
      salonComments = [];
      update();
    }
  }

  Future<void> _getSalonServices({required int id}) async {
    DataState<List<SalonService>> result =
        await _apiServices.getSingleSalonServices(salonId: id);
    if (result is DataSuccesState) {
      salonServices = result.data;
      update();
    }
    if (result is DataFailState) {
      salonServices = [];
      update();
    }
  }

  Future<void> getSalonDetail({required int id}) async {
    log('============fetching slon details============');
    isLoading = true;
    update();
    await _getSalonDeatail(id: id);
    await _getSalonServices(id: id);
    await _getSalonComments(id: id);
    Future.delayed(Duration(seconds: 5));
    await isBookedMarkedSalon();
    isLoading = false;
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
  Future<void> sendComment({
    required String comment,
    required int rate,
    required BuildContext context
  }) async {
    String? usertToken = await _storageService.getuserToken();
    if (usertToken != null) {
      isCommentLoading = true;
      update();
      DataState<bool> result = await _apiServices.sendComment(
          salonId: salonDetail!.id!,
          userToken: usertToken,
          comment: comment,
          rate: rate);
      if (result is DataSuccesState) {
        isCommentLoading = false;
        update();
        AwesomeDialog(
          context:context, 
          showCloseIcon: true,
          dialogType: DialogType.success, 
          borderSide: BorderSide(color:Colors.green), 
          dismissOnBackKeyPress: false, 
          dismissOnTouchOutside: true, 
          title: 'کامنت شما ثبت شد', 
          headerAnimationLoop: true, 
          desc: 'کامنت شما با موفقیت ثبت شد، بعد از تایید نمایش داده خواهد شد', 
          // btnOkOnPress: (){Get.back();},
          animType: AnimType.scale
        ).show();
      }
      if (result is DataFailState) {
        isCommentLoading=false;
        update();
        Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', result.error!,
            backgroundColor: Colors.red);
      }
    }
  }
// BUG bookmarked salon model need to change
  Future<void> isBookedMarkedSalon() async {
    String? token = await _storageService.getuserToken();
    print(token);
    if (token != null) {
      DataState<List<BookMarkedSalon>> bookmarkedSalon =
          await _apiServices.getBookMarkedSalons(userToken: token);
      if (bookmarkedSalon is DataSuccesState) {
         for (BookMarkedSalon element in bookmarkedSalon.data!) { 
          if(element.shop==salonId){
            isBookedMarked=true;
            update();
          }
         }
      } else {
        isBookedMarked = false;
        update();
      }
    }
  }

  Future<void> addSalonToBookMarks() async {
    String? token = await _storageService.getuserToken();
    if (token != null) {
      DataState<bool> reslult = await _apiServices.addSalonToBookMarks(
          token: token, salonId: salonDetail!.id!);
      if (reslult is DataSuccesState) {
        isBookedMarked = reslult.data!;
        update();
      } else {
        isBookedMarked = false;
        update();
      }
      if(reslult is DataFailState){
        Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', reslult.error!,
            backgroundColor: Colors.red);
      }
    }
    
  }

  Future<void> deleteSalonBookMark() async {
    String? token = await _storageService.getuserToken();
    if (token != null) {
      DataState<bool> result = await _apiServices.deleteSalonFromBookMarkList(
          userToken: token, salonId: salonDetail!.id!);
      if(result is DataSuccesState){
          isBookedMarked=false;
          update();
      }
      if(result is DataFailState){
        Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', result.error!,
            backgroundColor: Colors.red);
      }
    }
  }

  Future launchMApUrl(double lat, double lon) async {
    // String _url='https://www.google.com/maps/search/MM39%2BF63,+/@$lat,$lon,17z?hl=en';
    // if(!await launchUrl(lat, lon))
    final Uri url = Uri.parse(
        'https://www.google.com/maps/search/MM39%2BF63,+/@$lat,$lon,17z?hl=en');
    if (!await launchUrl(url)) {
      Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', 'دوباره تلاش کنید ',
          backgroundColor: Colors.red);
    }
  }

  @override
  void onInit() {
    super.onInit();
    salonId=Get.arguments['id'];
    getSalonDetail(id: Get.arguments['id']);
  }
}
