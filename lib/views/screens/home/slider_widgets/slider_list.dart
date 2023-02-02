import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/views/screens/home/slider_widgets/slider_widget.dart';
import 'package:sibzamini/views/views.dart';

class SliderList extends StatelessWidget {
  final List<Salon> salons;
  const SliderList({Key? key, required this.salons}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 240,
      // color: Colors.amber,
      child: salons.isNotEmpty?ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: salons.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SliderWidget(
            title: salons[index].name!,
            ratingCount: salons[index].rate!.toDouble(),
            imageUrl: salons[index].imgurl,
            onTap: () {
              Get.toNamed(rDetailScreen, arguments: {'id': salons[index].id});
            },
          );
        },
      ):Center(
        child: Column(
          children: [
            Transform.scale(
              scale: 0.6,
              child: SvgPicture.asset(Assets.icons.notFind),
            ), 
            Text('مشکلی در اتصال به سرور پیش امده', style: AppTextTheme.captionBold,)
          ],
        ),
      ),
    );
  }
}
