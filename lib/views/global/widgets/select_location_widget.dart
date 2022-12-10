

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';

class SelectLocationWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // throw UnimplementedError();
    return  InkWell(
      onTap: () {
        print('sh');
        _showCityLocationBottemSheet(context, MediaQuery.of(context).size.width);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: SolidColors.borderColor2,
            ),
          ),
        ),
        width:MediaQuery.of(context).size.width,
        height: 36,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: null,
                  icon: SvgPicture.asset(Assets.icons.location),
                ),
                Text(
                  'انتخاب‌محله',
                  style: TextStyle(color: SolidColors.textColor4),
                ),
              ],
            ),
            IconButton(
              onPressed: null,
              icon: SvgPicture.asset(
                Assets.icons.arrowBackFiiled,
                color: SolidColors.textColor4,
              ),
            )
          ],
        ),
      ),
    );
  }

    Future<dynamic> _showCityLocationBottemSheet(
      BuildContext context, double width) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
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
                      padding: EdgeInsets.symmetric(vertical: 10),
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: 20,
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
                                child: Text(
                                  'نام‌شهر',
                                  style: AppTextTheme.caption
                                      .copyWith(color: SolidColors.textColor4),
                                ),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

}