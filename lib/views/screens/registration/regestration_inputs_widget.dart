import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/constants/genral_input_decoration.dart';
import 'package:sibzamini/views/global/constants/persian_number_extension.dart';

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
        fillColor: SolidColors.darkGrey,
        prefixIcon: Container(
          // margin:,
          decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: SolidColors.borderColor))),
          child: Transform.scale(
              scale: 0.8, child: SvgPicture.asset(Assets.icons.iPad)),
        ),
        enabledBorder: genralInputDecoration,
        
        disabledBorder: genralInputDecoration,
        
        focusedBorder: genralInputDecoration,
        
        
        border: genralInputDecoration
        ),
      
    );
  }
}
