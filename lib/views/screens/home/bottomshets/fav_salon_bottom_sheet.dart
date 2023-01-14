import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/models/bookmarked_salon_model/book_marked_salon_model.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
Future<dynamic> showFavSalonBottomSheet(
    BuildContext context, List<BookMarkedSalon> bookMarkedSalons) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadiusDirectional.vertical(top: Radius.circular(25.0))),
    isScrollControlled: true,
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.3,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.icons.heart,
                    color: SolidColors.primaryBlue,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'علاقهمندی ها',
                    style: AppTextTheme.caption
                        .copyWith(color: SolidColors.primaryBlue),
                  ),
                ],
              ),
            ),
            Divider(height: 20, color: SolidColors.textColor4),
            Expanded(
              child: ListView.builder(
                itemCount: bookMarkedSalons.length,
                itemBuilder: (context, index) => Padding(
                  padding:EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    color: SolidColors.backGroundColor,
                    // padding: SolidColors
                    width: width,
                    height: height * 0.4,
                    child: Card(
                      // elevation: 12,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // image heder
                          SizedBox(
                            // color: Colors.amber,
                            width: width,
                            height: 210,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 10),
                                child: CachedNetworkImage(
                                  placeholder: ((context, url) => Container(
                                        child: Center(
                                            child: Transform.scale(
                                                scale: 0.5,
                                                child: Lottie.asset(
                                                    Assets.lotties.loading))),
                                      )),
                                  imageUrl:bookMarkedSalons[index].imgurl??
                                      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.shana.ir%2Fnews%2F462102%2F%25D8%25B1%25D9%2588%25D8%25A7%25D8%25A8%25D8%25B7-%25D8%25A7%25DB%258C%25D8%25B1%25D8%25A7%25D9%2586-%25D9%2588-%25DA%2586%25DB%258C%25D9%2586-%25D8%25B1%25D8%25A7%25D9%2587%25D8%25A8%25D8%25B1%25D8%25AF%25DB%258C-%25D8%25A7%25D8%25B3%25D8%25AA&psig=AOvVaw2NvlbKFHu40kX6ieFbwuEp&ust=1670824676692000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCMCqtJDx8PsCFQAAAAAdAAAAABAZ',
                                  imageBuilder: ((context, imageProvider) =>
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                  errorWidget: ((context, url, error) =>
                                      Container(
                                        color: Colors.grey,
                                        child: const Center(
                                          child: Icon(
                                            Icons.image_not_supported_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                )),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          /// [salon name and rating ]
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: SolidColors.backGroundColor,
                                  child: Center(
                                    child: Transform.scale(
                                        scale: 0.7,
                                        child:
                                            SvgPicture.asset(Assets.icons.logos)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bookMarkedSalons[index].name??
                                          'abolfzl',
                                      style: AppTextTheme.caption.copyWith(),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    // should get from server
                                    // RatingStars(
                                    //   rating:
                                    //   bookMarkedSalons[index].rateToDouble??
                                    //       0.0,
                                    //   editable: false,
                                    //   color: SolidColors.yellow,
                                    //   iconSize: 15,
                                    // )
                                  ],
                                )
                              ],
                            ),
                          ),

                          /// [fotter of card]
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                            width: width,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  // strokeAlign: StrokeAlign.center,
                                  color: SolidColors.textColor4.withOpacity(0.7),
                                ),
                              ),
                            ),
                            // color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 14),
                                  child: Text(
                                    '',
                                    // 'activeSetvice',
                                    // '${bookMarkedSalons[index]..toPersianDigit() ?? 0}خدمت فعال',
                                    style: AppTextTheme.subCaption
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          // controller.updateSelectedIndex(2);
                                        },
                                        icon: SvgPicture.asset(
                                            Assets.icons.commentsOutline)),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop;
                                          // if (builderController.isBookedMarked) {
                                          //   builderController
                                          //       .deleteSalonBookMark();
                                          // }
                                          // if (!builderController.isBookedMarked) {
                                          //   builderController
                                          //       .addSalonToBookMarks();
                                          // }
                                        },
                                        icon:
                                        // builderController.isBookedMarked
                                        //     ? Icon(Icons.favorite,
                                        //         color: Colors.red)
                                        //     :
                                        Icon(Icons.favorite,color:Colors.red)),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
