import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sibzamini/controller/home/home_controller.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/models/cities_model/cities_model.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';

Future<dynamic> showCityLocationBottemSheet(
    BuildContext context, double width, List<City> cities) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(25.0))),
      builder: (context) => Container(
            width: width,
            height: MediaQuery.of(context).size.height / 1.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: InkWell(
                      onTap: () {
                        // TODO IMPL THE AUTOMATIC LOCATION
                      },
                      child: Container(
                        child: Row(
                          children: [
                            SvgPicture.asset(Assets.icons.locationSearch),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'مکان‌یا‌بی‌خودکار',
                              style: AppTextTheme.caption
                                  .copyWith(color: SolidColors.primaryBlue),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  cities.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: cities.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: ((context, index) => Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: SolidColors.textColor4))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    child: TextButton(
                                      onPressed: () {
                                        Get.back();
                                        Get.find<HomeController>()
                                            .getHomeFeedSalons(
                                                cities[index].slug!);
                                      },
                                      child: Text(cities[index].name ?? '',
                                          style: AppTextTheme.caption.copyWith(
                                              color: SolidColors.textColor4)),
                                    ),
                                  ),
                                )),
                          ),
                        )
                      : Expanded(
                          // width:width,
                          child: Column(children: [
                            Transform.scale(
                                scale: 0.5,
                                child: SvgPicture.asset(Assets.icons.notFind)),
                            Text('موردی پیدا نشد بعدا تلاش کنید')
                          ]),
                        )
                ],
              ),
            ),
          ));
}
