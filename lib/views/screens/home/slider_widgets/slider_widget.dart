import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
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
      padding: EdgeInsets.all(8),
      child: SizedBox(
        width: 180,
        height: 100,
        child: InkWell(
          onTap: onTap,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 180,
                    height: 120,
                    decoration: BoxDecoration(
                      // color: Colors.green,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 180,
                    height: 120,
                    color: Colors.grey.withOpacity(0.6),
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => SizedBox(
                    width: 180,
                    height: 120,
                    child: Center(
                      child: Transform.scale(
                        scale: 0.4,
                        child: Lottie.asset(Assets.lotties.loading),
                      ),
                    ),
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 0.7,
                        child: CircleAvatar(
                          backgroundColor: Color(0xffF5F7FB),
                          child: SvgPicture.asset(Assets.icons.logos),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.justify,
                            style: AppTextTheme.caption.copyWith(
                              fontSize: 18,

                            ),

                          ),
                          RatingStars(
                              iconSize: 20,
                              rating: ratingCount,
                              editable: false,
                              color: SolidColors.yellow)
                        ],
                      )
                    ],
                  ),
                ), 
                // SizedBox(
                //   height: 5,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
