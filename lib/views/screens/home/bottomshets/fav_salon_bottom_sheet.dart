import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sibzamini/controller/controller.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/models/bookmarked_salon_model/book_marked_salon_model.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';

Future<dynamic> showFavSalonBottomSheet(BuildContext context) {
  List<BookMarkedSalon> bookMarkedSalons =
      Get.find<HomeController>().bookMarkedSalons;
  Get.find<HomeController>().refreshFavSalons();
  // HomeController controller=Get.find();
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
      child: GetBuilder<HomeController>(builder: (controller) {
        if (controller.isFavSalonLoading) {
          return Center(
            child: Transform.scale(
              scale: 0.4,
              child: Lottie.asset(Assets.lotties.loading),
            ),
          );
        }
        // if(controller.isDeleteFavLoading){
        //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //     showDialog(
        //         barrierDismissible: false,
        //         context: context, builder: (context)=>Transform.scale(
        //         scale: 0.2,
        //         child: Container(
        //             padding:EdgeInsets.all(4),
        //             child: Lottie.asset(Assets.lotties.loading))
        //     ));
        //   });
        // }
        return Padding(
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
                child: GetBuilder<HomeController>(
                  builder: (controller) => ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.bookMarkedSalons.length,
                      itemBuilder: (context, index) {
                        if (controller.bookMarkedSalons.isEmpty) {
                          return Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(Assets.icons.emptyBox,
                                      height: 250),
                                  SizedBox(height: 30),
                                  Text(
                                      'سالن های مورد علاقه خود را اضافه کنید و اینجا ببنید',
                                      style: AppTextTheme.captionBold)
                                ],
                              ),
                            ),
                          );
                        }
                        return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child:
                                _salonCart(controller, index, width, height));
                      }),
                ),
              )
            ],
          ),
        );
      }),
    ),
  );
}

_salonCart(HomeController controller, int index, double width, double height) {
  return InkWell(
    onTap: () {
      Get.toNamed(rDetailScreen,
          arguments: {'id': controller.bookMarkedSalons[index].id});
    },
    child: SizedBox(
      // padding: SolidColors
      width: width,
      height: height * 0.4,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // image heder
            SizedBox(
              // color: Colors.amber,
              width: width,
              height: 210,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: CachedNetworkImage(
                    placeholder: ((context, url) => Container(
                          child: Center(
                              child: Transform.scale(
                                  scale: 0.5,
                                  child: Lottie.asset(Assets.lotties.loading))),
                        )),
                    imageUrl: controller.bookMarkedSalons[index].imgurl ??
                        'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.shana.ir%2Fnews%2F462102%2F%25D8%25B1%25D9%2588%25D8%25A7%25D8%25A8%25D8%25B7-%25D8%25A7%25DB%258C%25D8%25B1%25D8%25A7%25D9%2586-%25D9%2588-%25DA%2586%25DB%258C%25D9%2586-%25D8%25B1%25D8%25A7%25D9%2587%25D8%25A8%25D8%25B1%25D8%25AF%25DB%258C-%25D8%25A7%25D8%25B3%25D8%25AA&psig=AOvVaw2NvlbKFHu40kX6ieFbwuEp&ust=1670824676692000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCMCqtJDx8PsCFQAAAAAdAAAAABAZ',
                    imageBuilder: ((context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    errorWidget: ((context, url, error) => Container(
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
                          child: SvgPicture.asset(Assets.icons.logos)),
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
                        controller.bookMarkedSalons[index].name ?? 'abolfzl',
                        style: AppTextTheme.caption.copyWith(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      '',
                      // 'activeSetvice',
                      // '${bookMarkedSalons[index]..toPersianDigit() ?? 0}خدمت فعال',
                      style: AppTextTheme.subCaption.copyWith(fontSize: 15),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            // controller.updateSelectedIndex(2);
                          },
                          icon: SvgPicture.asset(Assets.icons.commentsOutline)),
                      IconButton(
                          onPressed: () {
                            controller.deleteSalonFromFavorites(index, controller.bookMarkedSalons[index].id!);
                            print(index);
                          },
                          icon: Icon(Icons.favorite, color: Colors.red)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
