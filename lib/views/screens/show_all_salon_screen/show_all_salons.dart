import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:sibzamini/controller/all_salons_controller/all_salons_controller.dart';
import 'package:sibzamini/controller/controller.dart';
import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/services/local/connectivity_service.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/app_drawer.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';
import 'package:sibzamini/views/global/constants/genral_input_decoration.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';
import 'package:sibzamini/views/screens/home/bottomshets/select_city_location_bottom_sheet.dart';

class AllSalonsScreen extends GetView<AllSalonsController> {
  const AllSalonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: controller.drawerKey,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () {
              Get.back();
            },
          )
        ],
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset(Assets.icons.menu),
          onPressed: controller.openDrawer,
        ),
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
      drawer: AppDrawer(),
      body: GetBuilder<HomeController>(
        builder: (controller) {
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
          return Container(
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
                Text(
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

  _selectLocationSection(
    double width,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        showCityLocationBottemSheet(
            context,
            width,
            Get.find<HomeController>().availableCities,
            Get.find<HomeController>().autoSelectLocation);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: SolidColors.borderColor,
            ),
          ),
        ),
        width: width,
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
                  'تغییر شهر',
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

  _searchBar(
      {required double width,
      required double height,
      required BuildContext context}) {
    return InkWell(
      onTap: () {
        Get.offNamed(rSrarchSalons);
      },
      child: Container(
        decoration: BoxDecoration(
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
            IconButton(
              onPressed: () {
                Get.toNamed(rFavSalonsScreen,
                  arguments: {'salons': controller.bookMarkedSalons});
              },
              icon: SvgPicture.asset(Assets.icons.heart),
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
    return Expanded(child: GetBuilder<AllSalonsController>(
      builder: (builderController) {
        if (builderController.salons.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.icons.notFind),
                SizedBox(
                  height: 5,
                ),
                Text(
                  builderController.salonType == 'best'
                      ? 'بهترین سالن هایی برای این منطقه یافت نشد'
                      : builderController.salonType == 'newest'
                          ? 'جدید ترین سالن هایی برای این منطقه پیدا نشد '
                          : '',
                  style: AppTextTheme.captionBold,
                )
              ],
            ),
          );
        }
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: !builderController.isMoreLoadingEnd
                ? builderController.salons.length + 1
                : builderController.salons.length,
            itemBuilder: (context, index) {
              // bool isBookedMarked =
              //     controller.doseSalonBookedMarked();
              if (index == builderController.salons.length) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Center(
                      child: TextButton(
                        child: Text('نمایش بیشتر'),
                        onPressed: () {
                          builderController.loadMoreSalons();
                        },
                      ),
                    ),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: InkWell(
                    onTap: () {
                      Get.toNamed(rDetailScreen, arguments: {
                        'id': builderController.salons[index].id
                      });
                    },
                    child: SizedBox(
                        width: width,
                        child: Card(
                            child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: width,
                                  height: 200,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 10),
                                      child: CachedNetworkImage(
                                        placeholder: ((context, url) =>
                                            Container(
                                              child: Center(
                                                  child: Transform.scale(
                                                      scale: 0.5,
                                                      child: Lottie.asset(Assets
                                                          .lotties.loading))),
                                            )),
                                        imageUrl: builderController
                                            .salons[index].imgurl,
                                        imageBuilder: ((context,
                                                imageProvider) =>
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
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
                                                  Icons
                                                      .image_not_supported_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                      ))),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              SolidColors.backGroundColor,
                                          child: Center(
                                            child: Transform.scale(
                                                scale: 0.7,
                                                child: SvgPicture.asset(
                                                    Assets.icons.logos)),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              builderController
                                                      .salons[index].name ??
                                                  'abolfzl',
                                              style: AppTextTheme.caption
                                                  .copyWith(),
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
                                    )),
                                    Container(
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Get.toNamed(rDetailScreen,
                                                    arguments: {
                                                      'id': builderController
                                                          .salons[index].id
                                                    });
                                              },
                                              icon: SvgPicture.asset(Assets
                                                  .icons.commentsOutline)),
                                          IconButton(
                                              onPressed: () {
                                                Get.toNamed(rDetailScreen,
                                                    arguments: {
                                                      'id': builderController
                                                          .salons[index].id
                                                    });
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )))),
              );
            });
      },
    ));
  }
}
