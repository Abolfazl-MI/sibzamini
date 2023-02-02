import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:sibzamini/controller/detail/detail_controller.dart';
import 'package:sibzamini/controller/home/home_controller.dart';
import 'package:sibzamini/core/error_code.dart';

import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/app_drawer.dart';
import 'package:sibzamini/views/global/widgets/custome_shimmerh_loading.dart';
import 'package:sibzamini/views/global/widgets/search_bar_widget.dart';
import 'package:sibzamini/views/global/widgets/select_location_widget.dart';
import 'package:sibzamini/views/screens/comment_screen/comment_screen.dart';
import 'package:sibzamini/views/screens/location_screen/location_screen.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';
import '../../global/constants/constants.dart';
import 'package:sibzamini/services/local/connectivity_service.dart';

class DetailScreen extends GetView<DetailController> {
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController imageSliderController = PageController();

  DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      // key: scaffoldKey,
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
        // leading: IconButton(
        //   icon: SvgPicture.asset(Assets.icons.menu),
        //   onPressed: () {
        //     scaffoldKey.currentState!.openDrawer();
        //   },
        // ),
        centerTitle: true,
        title: Transform.scale(
            scale: 0.8, child: SvgPicture.asset(Assets.icons.logos)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      // drawer: AppDrawer(),
      body: GetBuilder<HomeController>(builder: (builderController) {
        if (builderController.connectivityStatus ==
            ConnectivityStatus.connected) {
          return _bodySection(context);
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
              Text(NO_INTERNET_CONNECTION, style: AppTextTheme.caption)
            ],
          ),
        );
      }),
    );
  }

  _bodySection(context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GetBuilder<DetailController>(
            builder: (controller) => IndexedStack(
              index: controller.selectedIndex,
              children: [
                _detailScreen(context),
                LocationScreen(),
                CommentScreen(),
              ],
            ),
          ),
        ),
        BottomNavigation(
          bodyMargin: 40,
          size: MediaQuery.of(context).size,
        )
      ],
    );
  }

  _detailScreen(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Shimmer(
      linearGradient: shimmerGradient,
      child: Scaffold(
          backgroundColor: SolidColors.backGroundColor,
          body: GetBuilder<DetailController>(
            builder: (builderController) => Column(
              children: [
                SearchBarWidget(),
                // SelectLocationWidget(),
                _body(width, height, builderController,context)
              ],
            ),
          )),
    );
  }

  _body(double width, double height, DetailController builderController, BuildContext context){
    return Expanded(
        child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          /// [Brand header realted]
          _brandHeader(builderController, width, height),

          const SizedBox(
            height: 30,
          ),

          /// [About us section]
          _aboutUs(builderController, width),
          // contiue from here
          const SizedBox(
            height: 20,
          ),

          /// [Services of salon]
          GetBuilder<DetailController>(builder: (dController) {
            // print(dController.salonServices);
            if (dController.salonServices == null ||
                dController.salonServices!.isEmpty) {
              return Container();
            }
            // TODO : should implement the services slider and image 
            // TODO: should complete this section
            
            if (dController.salonServices != null) {
              return Container(
                width: width,
                height: height * 0.4,
                // color: Colors.red,
                child: PageView.builder(
                  itemCount: dController.salonServices!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 40),
                      // width: 150,
                      // height: 150,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),

                                ///[service picture]
                                child: CachedNetworkImage(
                                  imageUrl: builderController
                                      .salonServices![index].imgUrl,
                                  errorWidget: ((context, url, error) =>
                                      Container(
                                        child: Center(
                                          child: Icon(
                                            Icons.image_not_supported_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                        width: width,
                                        height: height * 0.23,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      )),
                                  placeholder: (context, url) => Container(
                                    width: width,
                                    height: height * 0.23,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    // clipBehavior: ,
                                    child: Center(
                                        child: Transform.scale(
                                      scale: 0.5,
                                      child:
                                          Lottie.asset(Assets.lotties.loading),
                                    )),
                                  ),
                                  imageBuilder: ((context, imageProvider) =>
                                      Container(
                                        width: width,
                                        height: height * 0.23,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                                )),

                            ///[ services provides by salon should get from server]
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                builderController.salonServices![index].name!,
                                style: AppTextTheme.captionBold
                                    .copyWith(color: SolidColors.textColor3),
                              ),
                            ),
                            //
                            ///[the price of sercies]
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  // !in case that have off we use this code should maintane when connected to server
                                  // Text(
                                  //   '450,000'.toPersianDigit(),
                                  //   style: AppTextTheme
                                  //       .captionBold
                                  //       .copyWith(
                                  //           color: Colors.red,
                                  //           decoration:
                                  //               TextDecoration
                                  //                   .lineThrough),
                                  // ),
                                  // const SizedBox(
                                  //   width: 5,
                                  // ),
                                  Text(
                                    '${builderController.salonServices![index].amount!}'
                                        .toPersianDigit(),
                                    style: AppTextTheme.caption,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),

                                  const Text(
                                    'تومان',
                                    style: AppTextTheme.baseStyle,
                                  )
                                ],
                              ),
                            ),

                            /// [fotter of Card]
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(builderController
                                            .salonServices![index].content ??
                                        ''
                                    // 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز ',
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container();
          }),
           SizedBox(
            height: MediaQuery.of(context).size.height/10,
          ),
        ],
      ),
    ));
  }

  _brandHeader(
      DetailController builderController, double width, double height) {
    return ShimmerLoading(
      isLoading: builderController.isLoading,
      child: SizedBox(
        // color: Colors.green,
        // padding: EdgeInsets.all(10),
        width: width,
        height: height * 0.45,
        child: Card(
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
                      imageUrl: builderController.salonDetail?.imgurl ??
                          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.shana.ir%2Fnews%2F462102%2F%25D8%25B1%25D9%2588%25D8%25A7%25D8%25A8%25D8%25B7-%25D8%25A7%25DB%258C%25D8%25B1%25D8%25A7%25D9%2586-%25D9%2588-%25DA%2586%25DB%258C%25D9%2586-%25D8%25B1%25D8%25A7%25D9%2587%25D8%25A8%25D8%25B1%25D8%25AF%25DB%258C-%25D8%25A7%25D8%25B3%25D8%25AA&psig=AOvVaw2NvlbKFHu40kX6ieFbwuEp&ust=1670824676692000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCMCqtJDx8PsCFQAAAAAdAAAAABAZ',
                      placeholder: ((context, url) => Container(
                            child: Center(
                                child: Transform.scale(
                                    scale: 0.5,
                                    child:
                                        Lottie.asset(Assets.lotties.loading))),
                          )),
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
                          builderController.salonDetail?.name ?? 'abolfzl',
                          style: AppTextTheme.caption.copyWith(),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // should get from server
                        RatingStars(
                          rating: builderController.salonDetail?.rateToDouble ??
                              0.0,
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
                        '${builderController.salonServices?.length.toString().toPersianDigit() ?? 0}خدمت فعال',
                        style: AppTextTheme.subCaption.copyWith(fontSize: 15),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.updateSelectedIndex(2);
                            },
                            icon:
                                SvgPicture.asset(Assets.icons.commentsOutline)),
                        IconButton(
                            onPressed: () {
                              if (builderController.isBookedMarked) {
                                builderController.deleteSalonBookMark();
                              }
                              if (!builderController.isBookedMarked) {
                                builderController.addSalonToBookMarks();
                              }
                            },
                            icon: builderController.isBookedMarked
                                ? Icon(Icons.favorite, color: Colors.red)
                                : Icon(Icons.favorite_border)),
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

  ShimmerLoading _aboutUs(DetailController builderController, double width) {
    return ShimmerLoading(
      isLoading: builderController.isLoading,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width,
        color: builderController.salonDetail?.about!=null?Colors.white:null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              child: builderController.salonDetail?.about != null
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 5),
                          child: Text(
                            'درباره ما',
                            style: AppTextTheme.captionBold.copyWith(
                              color: SolidColors.primaryBlue,
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                          child: Text(
                            'خدمات ما چیست؟',
                            style: AppTextTheme.captionBold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          child: Text(builderController.salonDetail!.about!,
                              style: AppTextTheme.caption.copyWith(
                                  fontSize: 18, color: SolidColors.textColor4)),
                        ),
                      ],
                    )
                  : Container(),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigation extends GetView<DetailController> {
  const BottomNavigation({
    Key? key,
    required this.size,
    required this.bodyMargin,
  }) : super(key: key);

  final Size size;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 0,
      left: 0,
      child: Container(
        height: size.height / 12,
        decoration: const BoxDecoration(
            // color: Colors.green,

            ),
        child: Padding(
          padding: EdgeInsets.only(right: bodyMargin, left: bodyMargin),
          child: Container(
            height: size.height / 12,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: Colors.white,
            ),
            child: GetBuilder<DetailController>(
              builder: (controller) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: controller.isLoading
                        ? () {}
                        : () => controller.updateSelectedIndex(0),
                    icon: controller.selectedIndex == 0
                        ? SvgPicture.asset(Assets.icons.homeFill)
                        : SvgPicture.asset(
                            Assets.icons.homeOutline,
                          ),
                  ),
                  IconButton(
                      onPressed: controller.isLoading
                          ? () {}
                          : () => controller.updateSelectedIndex(1),
                      icon: controller.selectedIndex == 1
                          ? SvgPicture.asset(Assets.icons.locationlocationFill)
                          : SvgPicture.asset(
                              Assets.icons.locationlocationOutline)),
                  IconButton(
                    onPressed: controller.isLoading
                        ? () {}
                        : () => controller.updateSelectedIndex(2),
                    icon: controller.selectedIndex == 2
                        ? SvgPicture.asset(Assets.icons.commentsFill)
                        : SvgPicture.asset(Assets.icons.commentsOutline),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
