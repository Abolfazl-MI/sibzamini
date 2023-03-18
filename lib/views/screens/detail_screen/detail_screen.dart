import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
import 'package:sibzamini/views/global/widgets/custome_shimmerh_loading.dart';
import 'package:sibzamini/views/global/widgets/search_bar_widget.dart';
import 'package:sibzamini/views/screens/comment_screen/comment_screen.dart';
import 'package:sibzamini/views/screens/location_screen/location_screen.dart';
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Get.back();
          },
        ),
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
                // SearchBarWidget(),
                // SelectLocationWidget(),
                _body(width, height, builderController, context)
              ],
            ),
          )),
    );
  }

  _body(double width, double height, DetailController builderController,
      BuildContext context) {
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
          GetBuilder<DetailController>(
            builder: (dController) {
              if (dController.salonServices != null &&
                  dController.salonServices!.isNotEmpty) {
                return Container(
                  // color:Colors.white,
                  width: width,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'خدمات ما',
                    style: AppTextTheme.captionBold,
                  ),
                );
              }
              return Container();
            },
          ),

          /// [Services of salon]
          GetBuilder<DetailController>(builder: (dController) {
            // print(dController.salonServices);
            if (dController.salonServices == null ||
                dController.salonServices!.isEmpty) {
              return Container();
            }
            if (dController.salonServices != null) {
              print("${dController.salonServices!.length.toString()}<<<");
              return Container(
                  width: width,
                  height: height * 0.34,
                  // color: Colors.red,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      autoPlay: false,
                      height: height,
                      padEnds: false,
                      // aspectRatio: 0.,
                      disableCenter: true,
                      enableInfiniteScroll: false,
                    ),
                    itemCount: dController.salonServices!.length,
                    itemBuilder: (context, index, realIndex) {
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: _serviceCard(
                              builderController, index, width, height));
                    },
                  )
                  // child:ListView.builder(
                  //   padding: EdgeInsets.zero,
                  //   scrollDirection: Axis.horizontal,
                  //   itemCount: dController.salonServices!.length,
                  //   itemBuilder: (context,index){
                  //     return Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 0
                  //       ),
                  //       child: _serviceCard(builderController, index, width, height),
                  //     );
                  //   },
                  // )
                  // child: PageView.builder(
                  //   itemCount: dController.salonServices!.length,
                  //   itemBuilder: (context,index){
                  //     return _serviceCard(builderController, index, width, height);
                  //   },
                  // ),
                  );
            }
            return Container();
          }),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
        ],
      ),
    ));
  }

  Card _serviceCard(DetailController builderController, int index, double width,
      double height) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                imageUrl: builderController.salonServices![index].imgUrl,
                errorWidget: ((context, url, error) => Container(
                      width: width,
                      height: height * 0.23,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.white,
                        ),
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
                    child: Lottie.asset(Assets.lotties.loading),
                  )),
                ),
                imageBuilder: ((context, imageProvider) => Container(
                      width: width,
                      height: height * 0.23,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              )),

          ///[ services provides by salon should get from server]
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              builderController.salonServices![index].name!,
              style: AppTextTheme.captionBold
                  .copyWith(color: SolidColors.textColor3),
            ),
          ),
          //
          ///[the price of sercies]
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
              child: Text(builderController.salonServices![index].content ?? ''
                  // 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز ',
                  ),
            ),
          )
        ],
      ),
    );
  }

/* Card(
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
                                        width: width,
                                        height: height * 0.23,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.image_not_supported_outlined,
                                            color: Colors.white,
                                          ),
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
                      ) */
  _brandHeader(
      DetailController builderController, double width, double height) {
    return ShimmerLoading(
        isLoading: builderController.isLoading,
        child:
            // SizedBox(
            //   // color: Colors.green,
            //   // padding: EdgeInsets.all(10),
            //   width: width,
            //   height: height * 0.45,
            //   child: Card(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         // image heder

            //         const SizedBox(
            //           height: 5,
            //         ),

            //         /// [salon name and rating ]

            //         /// [fotter of card]
            //         const SizedBox(
            //           height: 3,
            //         ),
            //         ,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
                width: width,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // images
                      SizedBox(
                        width: width,
                        height: 200,
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
                                            child: Lottie.asset(
                                                Assets.lotties.loading))),
                                  )),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        builderController.salonDetail?.name ??
                                            'abolfzl',
                                        style: AppTextTheme.caption.copyWith(),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // should get from server
                                      RatingStars(
                                        rating: builderController
                                                .salonDetail?.rateToDouble ??
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
                            TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.transparent)),
                              onPressed: () {
                                if (builderController.isBookedMarked) {
                                  builderController.deleteSalonBookMark();
                                }
                                if (!builderController.isBookedMarked) {
                                  builderController.addSalonToBookMarks();
                                }
                              },
                              child: builderController.isBookedMarked
                                  ? Container(
                                    width: 100,
                                    height: 50,
                                      decoration: BoxDecoration(
                                          color: SolidColors.backGroundColor,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      padding: EdgeInsets.all(12),
                                      child: Center(
                                          child: Text('دنبال میکنید' '✓',
                                              style: AppTextTheme.captionBold
                                                  .copyWith(
                                                      color: SolidColors
                                                          .primaryBlue,
                                                      fontSize: 14))))
                                  : Container(
                                    width: 100,
                                    height: 50,
                                      decoration: BoxDecoration(
                                          color: SolidColors.primaryBlue,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      padding: EdgeInsets.all(12),
                                      child: Center(
                                          child: Text('دنبال کردن' '+',
                                              style: AppTextTheme.captionBold
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 14)))),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      // width: width,
                      // height: 70,
                      // decoration: BoxDecoration(
                      //   border: Border(
                      //     top: BorderSide(
                      //       // strokeAlign: StrokeAlign.center,
                      //       // color: Colors.red,
                      //       color: SolidColors.textColor4.withOpacity(0.7),
                      //     ),
                      //   ),
                      // ))
                      const SizedBox(height: 8,),

                      Padding(padding: EdgeInsets.symmetric(horizontal: 14),child:Divider(
                        color: SolidColors.textColor4.withOpacity(0.7),
                        thickness:1.5,
                      )), 
                      const SizedBox(height: 8,),
                      Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Align(
                              alignment: Alignment.centerRight,
                                                          child: Text(
                                '${builderController.salonServices?.length.toString().toPersianDigit() ?? 0}خدمت فعال',
                                style: AppTextTheme.subCaption.copyWith(fontSize: 15),
                              ),
                            ),
                          ),
                      const SizedBox(height: 8,),

                    ],
                  ),
                )));
  }

  ShimmerLoading _aboutUs(DetailController builderController, double width) {
    print(builderController.salonDetail?.about);
    return ShimmerLoading(
      isLoading: builderController.isLoading,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width,
        color:
            builderController.salonDetail?.about != null ? Colors.white : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              child: builderController.salonDetail?.about != null
                  ? Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            child: Row(
                              children: [
                                Text(
                                  'درباره ما',
                                  style: AppTextTheme.captionBold.copyWith(
                                    color: SolidColors.primaryBlue,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 2),
                            child: Row(
                              children: const [
                                Text(
                                  'خدمات ما چیست؟',
                                  style: AppTextTheme.captionBold,
                                ),
                              ],
                            )),
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
                        ? Icon(
                            Icons.house,
                            color: SolidColors.primaryBlue,
                          )
                        : Icon(
                            Icons.house_outlined,
                            color: SolidColors.textColor2,
                          ),
                  ),
                  IconButton(
                      onPressed: controller.isLoading
                          ? () {}
                          : () => controller.updateSelectedIndex(1),
                      icon: controller.selectedIndex == 1
                          ? Icon(Icons.phone, color: SolidColors.primaryBlue)
                          : Icon(Icons.phone_outlined,
                              color: SolidColors.textColor2)),
                  IconButton(
                    onPressed: controller.isLoading
                        ? () {}
                        : () => controller.updateSelectedIndex(2),
                    icon: controller.selectedIndex == 2
                        ? Icon(Icons.mode_comment,
                            color: SolidColors.primaryBlue)
                        : Icon(Icons.mode_comment_outlined,
                            color: SolidColors.textColor2),
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
