import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:sibzamini/controller/detail/detail_controller.dart';

import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/app_drawer.dart';
import 'package:sibzamini/views/global/widgets/search_bar_widget.dart';
import 'package:sibzamini/views/global/widgets/select_location_widget.dart';
import 'package:sibzamini/views/screens/comment_screen/comment_screen.dart';
import 'package:sibzamini/views/screens/location_screen/location_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../global/constants/constants.dart';

class DetailScreen extends GetView<DetailController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController imageSliderController = PageController();

  DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset(Assets.icons.menu),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        centerTitle: true,
        title: Transform.scale(
            scale: 0.8, child: SvgPicture.asset(Assets.icons.logos)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      drawer: AppDrawer(),
      body: Stack(
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
            bodyMargin: 50,
            size: MediaQuery.of(context).size,
          )
        ],
      ),
    );
  }

  _detailScreen(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final PageController sliderController = PageController();
    return Scaffold(
        backgroundColor: SolidColors.backGroundColor,
        body: Column(
          children: [
            SearchBarWidget(),
            SelectLocationWidget(),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  /// [BrandName]
                  Container(
                    color: SolidColors.darkGrey,

                    padding: EdgeInsets.all(10),
                    width: width,
                    height: height * 0.05,
                    // color: Colors.red,
                    // todo shoud change format coresponding to server
                    child: Text(
                      'اسم برند/خدمات پوست/سالن ایمان',
                      style: AppTextTheme.caption.copyWith(
                          fontSize: 18, color: SolidColors.textColor4),
                    ),
                  ),

                  /// [Brand header realted]
                  Container(
                    // color: Colors.green,
                    // padding: EdgeInsets.all(10),
                    width: width,
                    height: height * 0.37,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          /// [image slider]
                          //TODO SHOULD GET FORM SERVER

                          Container(
                            // color: Colors.amber,
                            width: width,
                            height: 208,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // image slider
                                SizedBox(
                                  width: width,
                                  height: 190,
                                  child: PageView.builder(
                                    controller: sliderController,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 10),
                                        child: Container(
                                          // color: Colors.blueAccent,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),

                                            /// [slider images settings]

                                            image: DecorationImage(
                                              image: AssetImage(
                                                Assets
                                                    .images
                                                    .femaleHairdresserMakingHairstyleRedheadWomanBeautySalon
                                                    .path,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                // dots under image
                                // TODO SHOULD GET FROM SERVER
                                Center(
                                  child: SmoothPageIndicator(
                                    controller: sliderController,
                                    effect: SlideEffect(
                                        activeDotColor: SolidColors.primaryBlue,
                                        dotColor: SolidColors.textColor4,
                                        dotHeight: 10,
                                        dotWidth: 10),
                                    count: 5,
                                  ),
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          /// [salon name and rating ]
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
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
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'سالن زیبایی ایمان',
                                      style: AppTextTheme.caption.copyWith(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // should get from server
                                    RatingStars(
                                      rating: 3,
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
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            width: width,
                            height: 40,
                            // color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  child: Text(
                                    '4'.toPersianDigit() + 'خدمت فعال',
                                    style: AppTextTheme.subCaption
                                        .copyWith(fontSize: 15),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: SvgPicture.asset(
                                            Assets.icons.commentsOutline)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: SvgPicture.asset(
                                            Assets.icons.heart)),
                                  ],
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  // strokeAlign: StrokeAlign.center,
                                  color:
                                      SolidColors.textColor4.withOpacity(0.7),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  /// [About us section]
                  Container(
                    padding: EdgeInsets.all(10),
                    width: width,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 2),
                          child: Text(
                            'خدمات ما چیست؟',
                            style: AppTextTheme.captionBold,
                          ),
                        ),
                        // TODO FETCHE FROM SERVER
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          child: Text(
                              "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد کتابهای زیادی در شصت و سه درصد گذشته حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد. و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد. و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد. و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد. و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد. و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد. ",
                              style: AppTextTheme.caption.copyWith(
                                  fontSize: 18, color: SolidColors.textColor4)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  // contiue from here
                  SizedBox(
                    height: 20,
                  ),

                  /// [Services of salon]
                  Container(
                    width: width,
                    height: height * 0.36,
                    // color: Colors.amber,
                    // TODO SHOULD GET FROM SERVEr
                    child: PageView.builder(
                      itemCount: 5,
                      padEnds: false,
                      itemBuilder: ((context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                          width: 150,
                          height: 150,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  //TODO should change to cachedNetWorkImage
                                  ///[service picture]
                                  child: Container(
                                    width: width,
                                    child: index==0?Stack(
                                      children: [
                                        Positioned(
                                          bottom: 20,
                                          right: 20,
                                          child: SizedBox(
                                            width: 90,
                                            height: 50,
                                            child: Card(
                                              color: SolidColors.primaryBlue,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  /// [image count should get from server]
                                                  SvgPicture.asset(Assets.icons.image),
                                                  Text('4'.toPersianDigit()+'عکس', style: AppTextTheme.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),), 
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ):null,
                                    height: height * 0.20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: AssetImage(Assets
                                            .images
                                            .femaleHairdresserMakingHairstyleRedheadWomanBeautySalon
                                            .path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                ///[ services provides by salon should get from server]
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                                  child: Text(
                                    'شنیون مو در سالن ایمان',
                                    style: AppTextTheme.captionBold
                                        .copyWith(color: SolidColors.textColor3),
                                  ),
                                ),
                                // 
                                ///[the price of sercies]
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                                  child: Row(
                                    children: [
                                      // in case that have off we use this code should maintane when connected to server
                                      Text(
                                        '450,000'.toPersianDigit(),
                                        style: AppTextTheme.captionBold.copyWith(
                                            color: Colors.red,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(
                                        '250,000'.toPersianDigit(),
                                        style: AppTextTheme.caption,
                                      ),
                                      SizedBox(width: 5,),

                                      Text(
                                        'تومان',
                                        style: AppTextTheme.baseStyle,
                                      )
                                    ],
                                  ),
                                ), 
                                /// [fotter of Card]
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز ', 
                                     
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                ],
              ),
            ))
          ],
        ));
  }
}

class BottomNavigation extends GetView<DetailController> {
  BottomNavigation({
    Key? key,
    required this.size,
    required this.bodyMargin,
  }) : super(key: key);

  final Size size;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
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
                    onPressed: () => controller.updateSelectedIndex(0),
                    icon: controller.selectedIndex == 0
                        ? SvgPicture.asset(Assets.icons.homeFill)
                        : SvgPicture.asset(
                            Assets.icons.homeOutline,
                          ),
                  ),
                  IconButton(
                      onPressed: () => controller.updateSelectedIndex(1),
                      icon: controller.selectedIndex == 1
                          ? SvgPicture.asset(Assets.icons.locationlocationFill)
                          : SvgPicture.asset(
                              Assets.icons.locationlocationOutline)),
                  IconButton(
                    onPressed: () => controller.updateSelectedIndex(2),
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
