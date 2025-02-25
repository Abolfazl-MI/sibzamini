import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:sibzamini/controller/controller.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/services/local/connectivity_service.dart';
import 'package:sibzamini/controller/searchSalon/search_salon_controller.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';
import 'package:sibzamini/views/global/constants/genral_input_decoration.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';
import 'package:sibzamini/views/screens/home/bottomshets/select_city_location_bottom_sheet.dart';
import 'package:sibzamini/views/global/widgets/custome_shimmerh_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchSalonsScreen extends GetView<SearchSalonsController> {
  const SearchSalonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: SolidColors.backGroundColor,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
        //
        // leading: IconButton(
        //   icon: SvgPicture.asset(Assets.icons.menu),
        centerTitle: true,
        title: Transform.scale(
            scale: 0.8, child: SvgPicture.asset(Assets.icons.logos)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: GetBuilder<HomeController>(builder: (builderController) {
        if (builderController.connectivityStatus ==
            ConnectivityStatus.connected) {
          return Column(
            children: [
              _searchBar(
                  width: width,
                  height: height,
                  context: context,
                  onchange: controller.updateSerchQuery),
              _selectLocationSection(width, context),
              _bodySection(width, height)
            ],
          );
        }
        return Container(child: Center(child: Text('abolfaz')));
      }),
    );
  }

  _bodySection(double width, double height) {
    return Expanded(
        child: Container(
            // color:Colors.yellow
            child: Shimmer(
      linearGradient: shimmerGradient,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
            height: height,
            // color:Colors.red,
            child: Column(children: [
              // _mostSeachedTitle(width),
              // GetBuilder<SearchSalonsController>(
              //   builder: (builderController) => ShimmerLoading(
              //       isLoading: builderController.isSearchLoading,
              //       child: Container(
              //           width: width, height: 200, color: Colors.green)),
              // ),
              SizedBox(
                height: 30,
              ),
              GetBuilder<SearchSalonsController>(
                builder: (builderController) => Expanded(
                    child: Container(
                  // color:Colors.yellow,
                  child: builderController.searchResult.isNotEmpty
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: builderController.searchResult.length,
                          itemBuilder: (context, index) {
                            Salon indexedSalon =
                                builderController.searchResult[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Get.toNamed(AppRoutes.rDetailScreen,
                                      arguments: {'id': indexedSalon.id});
                                  builderController.clearSrarchResult();
                                },
                                child: Card(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ShimmerLoading(
                                          isLoading:
                                              builderController.isSearchLoading,
                                          child: CachedNetworkImage(
                                            imageUrl: indexedSalon.pic ?? 'ssd',
                                            placeholder: (_, __) {
                                              return SizedBox(
                                                  width: 130,
                                                  height: 100,
                                                  child: Center(
                                                      child: Transform.scale(
                                                          scale: 0.5,
                                                          child: Lottie.asset(
                                                              Assets.lotties
                                                                  .loading))));
                                            },
                                            errorWidget: (___, __, _) {
                                              return Container(
                                                  width: 130,
                                                  height: 100,
                                                  color: Colors.grey,
                                                  child: Center(
                                                      child: Icon(
                                                          Icons
                                                              .image_not_supported_outlined,
                                                          color:
                                                              Colors.white)));
                                            },
                                            imageBuilder:
                                                (context, imageProvider) {
                                              return Container(
                                                width: 130,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: imageProvider)),
                                              );
                                            },
                                          )),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ShimmerLoading(
                                            isLoading: builderController
                                                .isSearchLoading,
                                            child: Text(
                                              indexedSalon.name!,
                                              style: AppTextTheme.captionBold,
                                            ),
                                          ),
                                          ShimmerLoading(
                                            isLoading: builderController
                                                .isSearchLoading,
                                            child: RatingStars(
                                              iconSize: 20,
                                              editable: false,
                                              rating: indexedSalon.rateToDouble,
                                              color: SolidColors.yellow,
                                            ),
                                          ),
                                          ShimmerLoading(
                                            isLoading: builderController
                                                .isSearchLoading,
                                            child: Text(
                                              'ادرس:' '${indexedSalon.address}',
                                              style: AppTextTheme.subCaption,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                              ),
                            );
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: builderController.isSearchLoading
                              ? Transform.scale(
                                  scale: 0.8,
                                  child: Lottie.asset(Assets.lotties.loading))
                              : SizedBox(
                                  width: width,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Transform.scale(
                                          scale: 1.5,
                                          child: SvgPicture.asset(
                                              Assets.icons.notFind),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(28.0),
                                          child: Text('موردی پیدا نشد',
                                              style: AppTextTheme.captionBold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                )),
              ),
              SizedBox(
                height: 20,
              ),
            ])),
      ),
    )));
  }

  _searchBar(
      {required double width,
      required double height,
      required BuildContext context,
      Function(String)? onchange}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: SolidColors.borderColor))),
      // padding: EdgeInsets.symmetric(
      //   horizontal: 16,
      // ),
      width: width,
      height: 56,
      // color: Colors.green,
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.offNamed(AppRoutes.rSrarchSalons);
                },
                child: SizedBox(
                  // height: 32,
                  child: GetBuilder<SearchSalonsController>(
                    builder: (controller) => TextFormField(
                        onChanged: onchange,
                        textAlign: TextAlign.justify,
                        autofocus: true,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: SolidColors.borderColor,
                            hintStyle: TextStyle(
                                fontSize: 12, color: SolidColors.textColor4),
                            hintText: 'دنبال‌چی‌میگردی؟',
                            enabledBorder: genralInputDecoration,
                            // enabled: false,
                            disabledBorder: genralInputDecoration,
                            focusedBorder: genralInputDecoration,
                            prefixIcon: controller.isSearchLoading
                                ? Transform.scale(
                                    scale: 0.8,
                                    child: Lottie.asset(Assets.lotties.loading))
                                : Icon(Icons.search))),
                  ),
                ),
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: SvgPicture.asset(Assets.icons.group),
          // ),
          IconButton(
            onPressed: () {
              Get.toNamed(
               AppRoutes. rFavSalonsScreen,
              );
            },
            icon: SvgPicture.asset(Assets.icons.heart),
          ),
        ],
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
            Get.find<SearchSalonsController>().autoSelectLocation);
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

  _mostSeachedTitle(double width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(children: const [
        Icon(Icons.local_fire_department_outlined),
        Text('سالن های برتر', style: AppTextTheme.captionBold)
      ]),
    );
  }

// _mostSerchedSalons(double width) {}
}
