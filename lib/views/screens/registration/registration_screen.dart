import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sibzamini/controller/controller.dart';
import 'package:sibzamini/gen/assets.gen.dart';
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
      backgroundColor: SolidColors.backGroundColor,
      body: Center(
        child: SizedBox(
          width: width,
          height: height / 1.5,
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
                        height: 37,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'ورود ',
                            style: TextStyle(
                                color: SolidColors.textColor4, fontSize: 14),
                            children: [
                              TextSpan(
                                  text: '|',
                                  style: TextStyle(
                                      color: SolidColors.borderColor)),
                              TextSpan(
                                  text: ' ثبت‌نام',
                                  style: TextStyle(
                                      color: SolidColors.textColor4,
                                      fontSize: 14)),
                            ]),
                      ),
                      const SizedBox(
                        height: 140,
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'شماره‌موبایل',
                          style: TextStyle(
                              color: SolidColors.textColor4, fontSize: 22),
                        ),
                      ),

                      RegistrationInput(
                          controller: phoneNumberController,
                          onchange: (value) {
                            controller.validatePhoneNumber(value);
                          },
                          validator: (value) =>
                              controller.validatePhoneNumber(value)
                          // key: formKey,
                          ),

                      const SizedBox(
                        height: 8,
                      ),
                      // Visibility(
                      //     child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: const [
                      //     Text(
                      //       '12:12',
                      //       style: TextStyle(color: SolidColors.textColor4),
                      //     ),
                      //     Text(
                      //       'مانده‌تا‌ارسال‌کد',
                      //       style: TextStyle(color: SolidColors.textColor4),
                      //     ),
                      //   ],
                      // )),
                      const SizedBox(
                        height: 62,
                      ),
                      InkWell(
                        onTap: () {
                          print('tapped');
                          formKey.currentState!.validate();
                        },
                        child: Container(
                          width: width,
                          height: 48,
                          decoration: BoxDecoration(
                              color: SolidColors.primaryBlue,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: SolidColors.borderColor)),
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
          ),
        ),
      ),
    );
  }
}
