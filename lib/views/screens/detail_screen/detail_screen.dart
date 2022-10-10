import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:sibzamini/controller/detail/detail_controller.dart';

import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/app_drawer.dart';
import 'package:sibzamini/views/screens/comment_screen/comment_screen.dart';
import 'package:sibzamini/views/screens/location_screen/location_screen.dart';

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
              builder:(controller)=> IndexedStack(
                index: controller.selectedIndex,
                children: [
                  _detailScreen(),
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

  _detailScreen() {
    return Scaffold(
      backgroundColor: SolidColors.backGroundColor,
      body: Center(
        child: Text('detail screen'),
      ),
    );
  }
}

class BottomNavigation extends GetView<DetailController> {
  BottomNavigation(
      {Key? key,
      required this.size,
      required this.bodyMargin,

     })
      : super(key: key);

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
              builder:(controller)=> Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: ()=>controller.updateSelectedIndex(0),
                    icon: controller.selectedIndex == 0
                        ? SvgPicture.asset(Assets.icons.homeFill)
                        : SvgPicture.asset(
                            Assets.icons.homeOutline,
                          ),
                  ),
                  IconButton(
                      onPressed: ()=>controller.updateSelectedIndex(1),
                      icon: controller.selectedIndex == 1
                          ? SvgPicture.asset(Assets.icons.locationlocationFill)
                          : SvgPicture.asset(
                              Assets.icons.locationlocationOutline)),
                  IconButton(
                    onPressed: ()=>controller.updateSelectedIndex(2),
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
