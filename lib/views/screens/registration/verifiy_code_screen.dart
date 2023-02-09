import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:sibzamini/controller/regestration/regestration_controller.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/widgets/loading_widget.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';
import 'package:sibzamini/views/screens/registration/regestration_inputs_widget.dart';
import "package:persian_number_utility/persian_number_utility.dart";
import '../../global/colors/solid_colors.dart';

class VerifyCodeScreen extends GetView<RegistrationController> {
  VerifyCodeScreen({Key? key}) : super(key: key);
  final TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: SolidColors.backGroundColor,
      body: GetBuilder<RegistrationController>(
        initState: (state) {
        controller.resendVerfiyCodeTimer();
      }, builder: (controller) {
        return Stack(
          children: [
            Center(
              child: SizedBox(
                width: width,
                // height: height / 1.7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: SolidColors.borderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.icons.logos),
                            SizedBox(
                              height: 20,
                            ),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'کد‌تایید',
                                style: TextStyle(
                                    color: SolidColors.textColor4,
                                    fontSize: 22),
                              ),
                            ),
                            AppInput(
                              keyboardType: TextInputType.number,
                                // hintText: '2568'.toPersianDigit(),
                                controller: otpController,
                                onchange: (value) {
                                  value.toPersianDigit();
                                  print(value);
                                  controller.validPenCode(value);
                                  if(value.length==4){
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    controller.confirmOtpCode(
                                        otpCode:
                                            otpController.text.toEnglishDigit(),
                                        phoneNumber: Get.arguments['mobile']);
                                    otpController.clear();
                                  }
                                },
                                validator: (value) =>
                                    controller.validatePhoneNumber(value)
                                // key: formKey,
                                ),
                            const SizedBox(height: 20),
                            GetBuilder<RegistrationController>(
                                builder: (controller) => controller.timeLaps > 0
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.timeLaps.toString(),
                                            style: TextStyle(
                                                color: SolidColors.textColor4),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'مانده‌تا‌ارسال‌کد‌مجدد',
                                            style: TextStyle(
                                                color: SolidColors.textColor4),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        // padding: EdgeInsets.all(8),
                                        child: TextButton(
                                          onPressed: () {
                                            controller.resendVerfiyCodeTimer();
                                          },
                                          child: Text('ارسال‌مجدد‌کد'),
                                        ),
                                      )),
                            const SizedBox(
                              height: 34,
                            ),
                            GetBuilder<RegistrationController>(
                              builder: (controller) => InkWell(
                                onTap: () {
                                  if (controller.isEnable) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    controller.confirmOtpCode(
                                        otpCode:
                                            otpController.text.toEnglishDigit(),
                                        phoneNumber: Get.arguments['mobile']);
                                  }
                                },
                                child: Container(
                                  width: width,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: controller.isEnable
                                          ? SolidColors.primaryBlue
                                          : SolidColors.textColor2,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: SolidColors.borderColor)),
                                  child: const Center(
                                      child: Text(
                                    'تایید‌ و‌ ادامه',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),

                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'شماره اشتباه وارد کردید؟',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: SolidColors.textColor4),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.offNamed(AppRoutes.rSignUpScreen);
                                    },
                                    child: Text(
                                      'اصلاح شماره',
                                      style: TextStyle(
                                          color: SolidColors.primaryBlue),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (controller.isLoading) const LoadingWidget()
          ],
        );
      }),
    );
  }
}
