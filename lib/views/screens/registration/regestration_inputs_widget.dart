import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:sibzamini/gen/assets.gen.dart';

import '../../global/colors/colors.dart';

class RegistrationInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onchange;
  final String? hintText;

  String? Function(String?)? validator;

  RegistrationInput(
      {Key? key,
      required this.controller,
      this.onchange,
      this.validator,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: validator,
      controller: controller,
      onChanged: onchange,
      
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 25),
        filled: true,
        hintText: hintText,
        fillColor: SolidColors.darkGrey,
        prefixIcon: Container(
          // margin:,
          decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: SolidColors.borderColor))),
          child: Transform.scale(
              scale: 0.8, child: SvgPicture.asset(Assets.icons.iPad)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: SolidColors.borderColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: SolidColors.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: SolidColors.borderColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: SolidColors.borderColor,
          ),
        ),
      ),
    );
  }
}
