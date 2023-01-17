import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
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
import 'package:sibzamini/views/screens/home/bottomshets/fav_salon_bottom_sheet.dart';
import 'package:sibzamini/views/screens/home/bottomshets/select_city_location_bottom_sheet.dart';

class AllSalonsScreen extends GetView<HomeController> {
  const AllSalonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: controller.allSalonsScaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
            icon:Icon(Icons.arrow_back_ios, color: Colors.grey,),
            onPressed: (){
              Get.back();
            },
          )
        ],
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset(Assets.icons.menu),
          onPressed: () {
            controller.allSalonsScaffoldKey.currentState!.openDrawer();
          },
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
                _bodySection(width, context, Get.arguments['salons'])
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
            context, width, Get.find<HomeController>().availableCities);
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
    return Container(
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
              showFavSalonBottomSheet(context, controller.bookMarkedSalons!);
            },
            icon: SvgPicture.asset(Assets.icons.heart),
          ),
        ],
      ),
    );
  }

  _bodySection(double width, BuildContext context, List<Salon> allSalons) {
    return Expanded(
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: allSalons.length + 1,
            itemBuilder: (context, index) {
              bool isBookedMarked =
                  controller.doseSalonBookedMarked(Get.arguments['salons']);
              if (index == allSalons.length) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Center(
                      child: TextButton(
                        child: Text('نمایش بیشتر'),
                        onPressed: () {},
                      ),
                    ),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(rDetailScreen,
                        arguments: {'id': allSalons[index].id});
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
                                  imageUrl: allSalons[index].imgurl ??
                                      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.shana.ir%2Fnews%2F462102%2F%25D8%25B1%25D9%2588%25D8%25A7%25D8%25A8%25D8%25B7-%25D8%25A7%25DB%258C%25D8%25B1%25D8%25A7%25D9%2586-%25D9%2588-%25DA%2586%25DB%258C%25D9%2586-%25D8%25B1%25D8%25A7%25D9%2587%25D8%25A8%25D8%25B1%25D8%25AF%25DB%258C-%25D8%25A7%25D8%25B3%25D8%25AA&psig=AOvVaw2NvlbKFHu40kX6ieFbwuEp&ust=1670824676692000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCMCqtJDx8PsCFQAAAAAdAAAAABAZ',
                                  imageBuilder: ((context, imageProvider) =>
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
                                        child: SvgPicture.asset(
                                            Assets.icons.logos)),
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
                                      allSalons[index].name ?? 'abolfzl',
                                      style: AppTextTheme.caption.copyWith(),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    // should get from server
                                    RatingStars(
                                      rating:
                                          allSalons[index].rateToDouble ?? 0.0,
                                      editable: false,
                                      color: SolidColors.yellow,
                                      iconSize: 15,
                                    )
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
                                  color:
                                      SolidColors.textColor4.withOpacity(0.7),
                                ),
                              ),
                            ),
                            // color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
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
                                          Get.toNamed(rDetailScreen,
                                              arguments: {
                                                'id': allSalons[index].id
                                              });
                                        },
                                        icon: SvgPicture.asset(
                                            Assets.icons.commentsOutline)),
                                    IconButton(
                                        onPressed: () {
                                          // print(allSalons[index].id);
                                          Get.toNamed(rDetailScreen,
                                              arguments: {
                                                'id': allSalons[index].id
                                              });
                                        },
                                        icon: isBookedMarked
                                            ? Icon(Icons.favorite,
                                                color: Colors.red)
                                            : Icon(
                                                Icons.favorite_border,
                                                color: Colors.black,
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
            }));
  }
}
