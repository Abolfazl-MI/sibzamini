import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';

import '../../../global/constants/constants.dart';

class SliderWidget extends StatelessWidget {
  final double ratingCount;
  final String title;
  final Function() onTap;
  final String imageUrl;
  const SliderWidget(
      {Key? key,
      required this.ratingCount,
      required this.title,
      required this.onTap,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: 180,
        height: 159,
        child: InkWell(
          onTap: onTap,
          child: Card(
            elevation: 0,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // image section
                // TODO: USE CACHENETWORK IMAGE
                Container(
                  width: 180,
                  height: 130,
                  decoration: BoxDecoration(
                    // color: Colors.green,
                    image: DecorationImage(
                        image: AssetImage(
                         imageUrl
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 0.9,
                      child: CircleAvatar(
                        backgroundColor: Color(0xffF5F7FB),
                        child: SvgPicture.asset(Assets.icons.logos),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          title,
                          style: AppTextTheme.caption,
                        ),
                        RatingStars(
                            iconSize: 20,
                            rating: ratingCount,
                            editable: false,
                            color: SolidColors.yellow)
                      ],
                    )
                  ],
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
