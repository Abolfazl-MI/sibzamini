import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/constants.dart';
import 'package:get/get.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed(rSrarchSalons);
      },
          child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: SolidColors.borderColor2))),
        width: MediaQuery.of(context).size.width,
        height: 56,
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  // height: 32,
                  child: TextFormField(
                    textAlign: TextAlign.justify,
                    enabled: false,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: SolidColors.borderColor,
                        hintStyle: TextStyle(
                            fontSize: 12, color: SolidColors.textColor4),
                        hintText: 'دنبال‌چی‌میگردی؟',
                        enabledBorder: genralInputDecoration,
                        disabledBorder: genralInputDecoration,
                        focusedBorder: genralInputDecoration,
                        prefixIcon: IconButton(
                          icon: SvgPicture.asset(
                            Assets.icons.search,
                            color: SolidColors.textColor4,
                          ),
                          onPressed: () => null,
                        )),
                  ),
                ),
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: SvgPicture.asset(Assets.icons.group),
            // ),
            // IconButton(
            //   onPressed: () {},
            //   icon: SvgPicture.asset(Assets.icons.heart),
            // ),
          ],
        ),
      ),
    );
  }
}
