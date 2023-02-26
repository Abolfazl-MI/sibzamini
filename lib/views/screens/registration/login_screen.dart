import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sibzamini/controller/controller.dart';
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/services/local/connectivity_service.dart';
import 'package:sibzamini/views/global/widgets/loading_widget.dart';
import 'package:sibzamini/views/screens/registration/regestration_inputs_widget.dart';
import 'package:sibzamini/views/views.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  final TextEditingController phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: SolidColors.backGroundColor,
      body: GetBuilder<RegistrationController>(builder: (controller) {
        if(controller.isLoading){
          return Container(
            width: width,
            height: height,
            color: Colors.white,
            child:Center(
              child:Transform.scale(
                scale: 0.8,
                child: Lottie.asset(Assets.lotties.loading),
              )
            )
          ); 

        }
        return Container(
          width: width,
          height: height,
          color: Colors.white,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              width: width,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Container(
                          padding: EdgeInsets.all(12),
                          width: width,
                          height: height * 0.5,
                          // color: Colors.red,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Assets.icons.logos),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'ورود با شماره',
                                ),
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'شماره‌موبایل',
                                    style: TextStyle(
                                        color: SolidColors.textColor4,
                                        fontSize: 22),
                                  ),
                                ),
                                AppInput(
                                    keyboardType: TextInputType.number,
                                    controller: phoneNumberController,
                                    hintText: "*******0912".toPersianDigit(),
                                    onchange: (value) {
                                      value.toPersianDigit();
                                    },
                                    validator: (value) =>
                                        controller.validatePhoneNumber(value)),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(height: height * 0.05),
                                InkWell(
                                  onTap: () async {
                                    await InternetConnectivityService()
                                        .isInterNetEnabled()
                                        .then((DataState dataState) {
                                      print('ok!');
                                      if (dataState is DataSuccesState) {
                                        if (formKey.currentState!.validate()) {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          controller.requestLoginUser(
                                              phoneNumber: phoneNumberController
                                                  .text
                                                  .toEnglishDigit());
                                        }
                                        print(dataState.data);
                                      }
                                      if (dataState is DataFailState) {
                                        AwesomeDialog(
                                          context: context,
                                          showCloseIcon: true,
                                          dialogType: DialogType.error,
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          dismissOnBackKeyPress: false,
                                          dismissOnTouchOutside: false,
                                          headerAnimationLoop: false,
                                          title: 'مشکل پیش اومده',
                                          desc: dataState.error,
                                          animType: AnimType.leftSlide,
                                        ).show();
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: width,
                                    height: 48,
                                    decoration: BoxDecoration(
                                        color: SolidColors.primaryBlue,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: SolidColors.borderColor)),
                                    child: const Center(
                                        child: Text(
                                      'ارسال‌کد',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'اکانت نداری؟',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: SolidColors.textColor4),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.offNamed(AppRoutes.rSignUpScreen);
                                        },
                                        child: Text(
                                          'ثبت نام کن',
                                          style: TextStyle(
                                              color: SolidColors.primaryBlue),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
/* SizedBox(
                width: width,
                // height: height / 1.6,
                height: height,
                child: Card(
                  color: Colors.white,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(12),
                  //   side: const BorderSide(color: SolidColors.borderColor),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Assets.icons.logos),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'ورود با شماره',
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'شماره‌موبایل',
                              style: TextStyle(
                                  color: SolidColors.textColor4,
                                  fontSize: 22),
                            ),
                          ),
                          AppInput(
                              keyboardType: TextInputType.number,
                              controller: phoneNumberController,
                              hintText: "*******0912".toPersianDigit(),
                              onchange: (value) {
                                value.toPersianDigit();
                              },
                              validator: (value) =>
                                  controller.validatePhoneNumber(value)),
                          const SizedBox(
                            height: 8,
                          ),
                          const SizedBox(
                            height: 62,
                          ),
                          InkWell(
                            onTap: () async{
                              await InternetConnectivityService()
                                  .isInterNetEnabled()
                                  .then((DataState dataState) {
                                    print('ok!');
                                if (dataState is DataSuccesState) {
                                  if (formKey.currentState!.validate()) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    controller.requestLoginUser(
                                        phoneNumber: phoneNumberController
                                            .text
                                            .toEnglishDigit());
                                  }
                                  print(dataState.data);
                                }
                                if (dataState is DataFailState) {
                                  AwesomeDialog(
                                    context: context,
                                    showCloseIcon: true, 
                                    dialogType: DialogType.error, 
                                    borderSide: BorderSide(color:Colors.red), 
                                    dismissOnBackKeyPress: false, 
                                    dismissOnTouchOutside: false,
                                    headerAnimationLoop: false,
                                    title: 'مشکل پیش اومده', 
                                    desc: dataState.error, 
                                    animType: AnimType.leftSlide, 

                                  ).show();
                                }
                              });
                            },
                            child: Container(
                              width: width,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: SolidColors.primaryBlue,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: SolidColors.borderColor)),
                              child: const Center(
                                  child: Text(
                                'ارسال‌کد',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ); */
