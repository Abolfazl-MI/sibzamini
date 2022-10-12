import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';
import 'package:sibzamini/views/global/constants/genral_input_decoration.dart';
import 'package:sibzamini/views/global/constants/persian_number_extension.dart';

import '../../global/colors/colors.dart';

class AppInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onchange;
  final String? hintText;
  final Widget? icon;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? hintTextstyle;
  String? Function(String?)? validator;

  AppInput(
      {Key? key,
      required this.controller,
      this.onchange,
      this.validator,
      this.hintText,
      this.icon,
      this.fillColor,
      this.borderColor,
      this.hintTextstyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: validator,
      controller: controller,
      onChanged: onchange,
      inputFormatters: [
        TextInputFormatter.withFunction((oldValue, newValue) {
          return newValue.copyWith(
              text: newValue.text.replaceMap(enToFaNumberMap));
        })
      ],
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 25),
          filled: true,
          hintText: hintText,
          hintStyle: hintTextstyle ?? null,
          fillColor: fillColor ?? SolidColors.darkGrey,
          prefixIcon: icon ??
              Container(
                // margin:,
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(color: SolidColors.borderColor))),
                child: Transform.scale(
                    scale: 0.8, child: SvgPicture.asset(Assets.icons.iPad)),
              ),
          enabledBorder: genralInputDecoration.copyWith(),
          disabledBorder: genralInputDecoration,
          focusedBorder: genralInputDecoration,
          border: genralInputDecoration),
    );
  }
}

class AppBigInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onchange;
  final String? hintText;
  final Widget? icon;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? hintTextstyle;
  String? Function(String?)? validator;
  final double height;

  AppBigInput(
      {super.key,
      required this.controller,
      this.onchange,
      this.hintText,
      this.icon,
      this.fillColor,
      this.borderColor,
      this.hintTextstyle,
      required this.height});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: TextField(
        keyboardType: TextInputType.number,
        // validator: validator,j
        controller: controller,
        onChanged: onchange,
        inputFormatters: [
          TextInputFormatter.withFunction((oldValue, newValue) {
            return newValue.copyWith(
                text: newValue.text.replaceMap(enToFaNumberMap));
          })
        ],

        decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(20),
            filled: true,
            hintText: hintText,
            hintStyle: hintTextstyle ?? null,
            fillColor: fillColor ?? SolidColors.darkGrey,
            // prefixIcon:icon?? Container(
            //   // margin:,
            //   decoration: const BoxDecoration(
            //       border: Border(left: BorderSide(color: SolidColors.borderColor))),
            //   child: Transform.scale(
            //       scale: 0.8, child: SvgPicture.asset(Assets.icons.iPad)),
            // ),

            enabledBorder: genralInputDecoration.copyWith(),
            disabledBorder: genralInputDecoration,
            focusedBorder: genralInputDecoration,
            border: genralInputDecoration),
      ),
    );
  }
}

Widget buildTextField(
    {required String hintText, required TextEditingController controller}) {
  final maxLines = 5;

  return Container(
    // margin: EdgeInsets.all(12),
    height: maxLines * 24.0,
    child: TextField(
      
      maxLines: maxLines,
      decoration: InputDecoration(
        hintStyle: AppTextTheme.subCaption.copyWith(
                            color: SolidColors.textColor5, 
                            fontSize: 15
                          ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: SolidColors.borderColor2)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: SolidColors.borderColor2)
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: SolidColors.borderColor2)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: SolidColors.borderColor2)
        ),
        hintText: hintText,
        fillColor: SolidColors.darkGrey,
        filled: true,
      ),
    ),
  );
}
