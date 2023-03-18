import 'package:app_settings/app_settings.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/services/local/location_service.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';

Future showLocationErrorDialog(String error) async {
  switch (error) {
    case DISSABLED_LOCATION_SERVICE:
      AwesomeDialog(
          context: Get.context!,
          title: 'سرویس موقعیت یابی خاموش است!',
          desc:
              'برای ادامه استفاده از اپلیکیشن لطفا سرویس موقعیت یابی را فعال کنید ',
          animType: AnimType.topSlide,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          descTextStyle: AppTextTheme.captionBold,
          titleTextStyle: AppTextTheme.header,
          dialogType: DialogType.warning,
          btnOkColor: SolidColors.primaryBlue,
          btnOkText: 'متوجه شدم، الان فعال میکنم',
          btnOkOnPress: () async {
            await AppSettings.openLocationSettings();
          }).show();
      break;
    case LOCATION_ACCESS_DENIDD:
      AwesomeDialog(
          context: Get.context!,
          title: 'دسترسی به سرویس موفعیت یابی محدود شده است',
          desc:
              'برای ادامه استفاده از اپلیکیشن لطفادسترسی سرویس موقعیت یابی را فعال کنید ',
          animType: AnimType.topSlide,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          descTextStyle: AppTextTheme.captionBold.copyWith(fontSize: 12),
          titleTextStyle: AppTextTheme.header.copyWith(fontSize: 15),
          dialogType: DialogType.warning,
          btnOkColor: SolidColors.primaryBlue,
          btnOkText: 'متوجه شدم، الان دسترسی میدم',
          btnOkOnPress: () async {
            await LocationServices().requestPermisionAgain().then((bool isPermisionGranted) {
              if (isPermisionGranted){
                Get.offNamed(AppRoutes.rSplashScreen);
              }else{
                Get.offNamed(AppRoutes.rErrorScreen, arguments: {'error':LOCATION_ACCESS_DENIDD});
              }
            });

          }).show();
      break;
    case SOMETHING_WENT_WRONG:
      Get.offNamed(
        AppRoutes.rErrorScreen,
        arguments: {
          'error': SOMETHING_WENT_WRONG,
        },
      );
      break;
  }
}
