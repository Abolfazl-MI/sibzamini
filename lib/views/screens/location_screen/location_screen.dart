import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/colors/colors.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';
import 'package:sibzamini/views/global/widgets/search_bar_widget.dart';
import 'package:sibzamini/views/global/widgets/select_location_widget.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: SolidColors.backGroundColor,
        body: Column(
          children: [
            SearchBarWidget(),
            SelectLocationWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// [BrandName]
                    Container(
                      padding: EdgeInsets.all(10),
                      width: width,
                      height: height * 0.05,
                    color: SolidColors.darkGrey,

                      // color: Colors.red,
                      // todo shoud change format coresponding to server
                      child: Text(
                        'اسم برند/خدمات پوست/سالن ایمان',
                        style: AppTextTheme.caption.copyWith(
                            fontSize: 18, color: SolidColors.textColor4),
                      ),
                    ),
                   
                    // TODO should get map  from more detail

                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Container(
                              width: width,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: SolidColors.darkBlue)),
                              child: Image.asset(
                                Assets.images.fakeMap.path,
                                fit: BoxFit.cover,
                              )),
                          Positioned(
                            top: 180,
                            left: 180,
                            child: CircleAvatar(
                              maxRadius: 25,
                              child: Center(
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: SvgPicture.asset(
                                    Assets.icons.locationlocationOutline,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: width,
                      // height: 100,
                      color: Colors.white,
                      child: Column(
                        children: [
                          ///TODO [Salon Address should go from server]
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'آدرس' + ':',
                                  style: AppTextTheme.captionBold,
                                ),
                                Text(
                                  'خیابان امام علی،کوچه امام رضا ،پلاک22',
                                  style: AppTextTheme.caption
                                      .copyWith(color: SolidColors.textColor4),
                                )
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: InkWell(
                              child: Row(
                                  children: [
                                    Text(
                                      'بازکردن نقشه',
                                      style: AppTextTheme.captionBold.copyWith(
                                          fontSize: 18,
                                          color: SolidColors.primaryBlue),
                                    ),
                                    Icon(
                                      Icons.arrow_back_ios_new,
                                      color: SolidColors.primaryBlue,
                                      size: 18,
                                    ),
                                  ],
                              ),
                            ),
                               ),
                            ]
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
