import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sibzamini/controller/controller.dart';

import 'package:sibzamini/gen/assets.gen.dart';

import 'package:sibzamini/views/screens/home/carsol_widget.dart';
import 'package:sibzamini/views/screens/home/slider_widgets/slider_list.dart';
import 'package:sibzamini/views/views.dart';

import 'slider_widgets/slider_header.dart';

const _drawerText = [
  'همه',
  'اکسیشن‌مو',
  'رنگ‌لایت‌مو',
  'خدمات‌ناخان',
  'خدمات‌لیزر',
  'خدمات‌تزریق‌ژل',
  'خدمات‌کراتینه',
  'خدمات‌پوست',
];

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: SolidColors.backGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset(Assets.icons.menu),
          onPressed: () {
            controller.openDrawer();
          },
        ),
        centerTitle: true,
        title: Transform.scale(
            scale: 0.8, child: SvgPicture.asset(Assets.icons.logos)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      drawer: SafeArea(
        child: Container(
          width: width / 1.5,
          height: height / 1.001,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: SvgPicture.asset(Assets.icons.logos),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    height: 0.8,
                    color: SolidColors.textColor4,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ...List.generate(
                    _drawerText.length,
                    (index) => InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              _drawerText[index],
                              style: AppTextTheme.caption.copyWith(
                                  color: SolidColors.textColor4, fontSize: 17),
                            ),
                          ),
                        )),
              ],
            ),
          ),
        ),
      ),
      /*     Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(
                      8,
                      (index) => Text(
                        drawerText[index],
                        style: AppTextTheme.caption,
                      ),
                    ),
                  ),
                ) */
      body: Column(
        children: [
          _searchBar(
            width: width,
            height: height,
            context: context,
          ),
          _selectLocationSection(width, context),
          // body rest items
          _bodySection(width)
        ],
      ),
    );
  }

  _bodySection(double width) {
    return Expanded(
        child: Container(
      // color: Colors.amber,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              _carsol_section(width),
              SizedBox(
                height: 12,
              ),
              SliderHeader(
                  rightText: 'بهترین‌سالن‌های‌اطراف‌شما',
                  leftText: 'نمایش‌ همه',
                  onTap: () {}),
              SizedBox(
                height: 12,
              ),
              SliderList(),
              SizedBox(
                height: 20,
              ),
              _addSection(width),
              SizedBox(
                height: 12,
              ),
              SliderHeader(
                  rightText: 'جدید‌ترین‌سالن‌ها',
                  leftText: 'نمایش‌ همه',
                  onTap: () {}),
              SizedBox(
                height: 12,
              ),
              SliderList(),
              SizedBox(
                height: 22,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  _addSection(double width) {
    return Container(
        width: width,
        height: 275,

        // color: Colors.amber,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.images.cardbg.path,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: width / 3.5,
              height: 275,
              // color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'سالن‌های',
                        style:
                            AppTextTheme.header.copyWith(color: Colors.white),
                      ),
                      Text(
                        'تخفیف‌دار',
                        style:
                            AppTextTheme.header.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'نمایش‌همه',
                        style:
                            AppTextTheme.caption.copyWith(color: Colors.white),
                      ),
                      SvgPicture.asset(
                        Assets.icons.arrowBackThinBlue,
                        color: Colors.white,
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      width: 180,
                      height: 175,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(
                              Assets.images.slaon.path,
                            ),
                            fit: BoxFit.cover),
                      ),
                      // color: Colors.amber,
                    ),
                  );
                }),
                itemCount: 5,
              ),
            )
          ],
        ));
  }

  Padding _carsol_section(double width) {
    return Padding(
      padding: EdgeInsets.symmetric(
        // horizontal: 5,
        vertical: 16,
      ),
      child: CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: ((context, index, realIndex) => CarsolWidget(
            imgSrc: Assets.images.modernBeautySalonInterior2.path,
            width: width)),
        options: CarouselOptions(
          height: 120,
          autoPlay: true,
          autoPlayCurve: Curves.decelerate,
        ),
      ),
    );
  }

/* Container(
                  width: width,
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                            onTap: () {
                              // TODO IMPL THE AUTOMATIC LOCATION
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  SvgPicture.asset(Assets.icons.locationSearch),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'مکان‌یا‌بی‌خودکار',
                                    style: AppTextTheme.caption.copyWith(
                                        color: SolidColors.primaryBlue),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 20,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: ((context, index) => Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: SolidColors.textColor4))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    child: Text(
                                      'نام‌شهر',
                                      style: AppTextTheme.caption.copyWith(
                                          color: SolidColors.textColor4),
                                    ),
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ) */
  _selectLocationSection(double width, BuildContext context) {
    return InkWell(
      onTap: () {
        print('sh');
        _showCityLocationBottemSheet(context, width);
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
                  'انتخاب‌محله',
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

  Future<dynamic> _showCityLocationBottemSheet(
      BuildContext context, double width) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
              width: width,
              height: MediaQuery.of(context).size.height / 1.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {
                          // TODO IMPL THE AUTOMATIC LOCATION
                        },
                        child: Container(
                          child: Row(
                            children: [
                              SvgPicture.asset(Assets.icons.locationSearch),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'مکان‌یا‌بی‌خودکار',
                                style: AppTextTheme.caption
                                    .copyWith(color: SolidColors.primaryBlue),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 20,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: ((context, index) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: SolidColors.textColor4))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                child: Text(
                                  'نام‌شهر',
                                  style: AppTextTheme.caption
                                      .copyWith(color: SolidColors.textColor4),
                                ),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  _searchBar(
      {required double width,
      required double height,
      required BuildContext context}) {
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
            onPressed: () {},
            icon: SvgPicture.asset(Assets.icons.group),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(Assets.icons.heart),
          ),
        ],
      ),
    );
  }
}
