import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/screens/home/slider_widgets/slider_widget.dart';
import 'package:sibzamini/views/views.dart';

class SliderList extends StatelessWidget {
  // TODO GET THE LIST AND USE IT HERE

  const SliderList({Key? key}) : super(key: key);
// TODO: SHOULD GET LIST OF AVALABLE STH THEN USE
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 220,
      // color: Colors.amber,
      child: ListView.builder(
        itemCount: 20,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // TODO: Attention HARD CODE HERE SHOULD REPLACE WITH REALL DATA
          return SliderWidget(
            title: 'سالن‌زیبایی‌ایمان',
            ratingCount: 2,
            imageUrl: Assets.images.modernBeautySalonInterior2.path,
            onTap: () {
              Get.toNamed(rDetailScreen);
            },
          );
        },
      ),
    );
  }
}
