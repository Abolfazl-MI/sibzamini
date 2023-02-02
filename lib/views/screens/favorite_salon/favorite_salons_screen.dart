import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sibzamini/controller/bookMark_controller/bookMark_controller.dart';
import 'package:sibzamini/controller/home/home_controller.dart';
import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/services/local/connectivity_service.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';
import 'package:sibzamini/views/global/constants/genral_input_decoration.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';

class FavoriteSalonScreen extends GetView<BookMarkedSalonController> {
  const FavoriteSalonScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () {
              Get.back();
            },
          )
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Transform.scale(
          scale: 0.8,
          child: SvgPicture.asset(
            Assets.icons.logos,
          ),
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.isDeleteFavLoading) {
            return Center(
                child: Transform.scale(
              scale: 0.8,
              child: Lottie.asset(Assets.lotties.loading),
            ));
          }
          if (controller.connectivityStatus == ConnectivityStatus.connected) {
            return Column(
              children: [
                _searchBar(width: width, height: height, context: context),
                // _selectLocationSection(width, context),
                _bodySection(
                  width,
                  context,
                )
              ],
            );
          }
          return SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Transform.scale(
                    scale: 0.5,
                    child: Lottie.asset(Assets.lotties.noInternet),
                  ),
                ),
                const Text(
                  NO_INTERNET_CONNECTION,
                  style: AppTextTheme.caption,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _searchBar(
      {required double width,
      required double height,
      required BuildContext context}) {
    return InkWell(
      onTap: () {
        Get.toNamed(rSrarchSalons);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: SolidColors.borderColor,
            ),
          ),
        ),
        width: width,
        height: 56,
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  // height: 32,
                  child: TextFormField(
                    enabled: false,
                    textAlign: TextAlign.justify,
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
          ],
        ),
      ),
    );
  }

  _bodySection(
    double width,
    BuildContext context,
  ) {
    return Expanded(
        child: GetBuilder<BookMarkedSalonController>(
      builder: (buildercontroller) => (ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: buildercontroller.salons.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: InkWell(
                onTap: () {
                  Get.toNamed(rDetailScreen, arguments: {
                    'id': buildercontroller.salons[index].shop
                  });
                },
                child: SizedBox(
                  // padding: SolidColors
                  width: width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
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
                                imageUrl: buildercontroller
                                        .salons[index].imgurl,
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
                                    buildercontroller
                                            .salons[index].name ??
                                        'abolfzl',
                                    style: AppTextTheme.caption.copyWith(),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  // should get from server
                                  // RatingStars(
                                  //   rating:
                                  //       allSalons[index].rateToDouble ?? 0.0,
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
                                  // '${allSalons[index]..toPersianDigit() ?? 0}خدمت فعال',
                                  style: AppTextTheme.subCaption
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Get.toNamed(rDetailScreen, arguments: {
                                          'id': buildercontroller
                                              .salons[index].shop
                                        });
                                      },
                                      icon: SvgPicture.asset(
                                          Assets.icons.commentsOutline)),
                                  IconButton(
                                      onPressed: () {
                                        buildercontroller
                                            .deleteSalonFromFavorites(
                                                index,
                                                buildercontroller
                                                    .salons[index]
                                                    .shop!);
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )),
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
            );
          })),
    ));
  }
}
