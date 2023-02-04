import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../gen/assets.gen.dart';

class CarsolWidget extends StatelessWidget {
  final String imgSrc;
  final double width;

  const CarsolWidget({super.key, required this.imgSrc, required this.width});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgSrc,
      imageBuilder: (((context, imageProvider) => Container(
            width: width,
            margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(
              image: imageProvider, 
              fit: BoxFit.fill
            )),
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                  left: 20,
                  child: Container(
                    width: 96,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Color(0xff343434),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'مشاهده',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 36,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.white),
                          child: Transform.scale(
                              scale: 0.6,
                              child: SvgPicture.asset(Assets.icons.arrowLeft)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ))),
          errorWidget: (((context, url, error) => Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.grey, 
              borderRadius: BorderRadius.circular(12)
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Icon(Icons.image_not_supported_outlined,color: Colors.white,),
            ),
          ))),
          placeholder: (((context, url) => Container(
            width: width,
            margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), 
            ),
            child: Center(
              child: Transform.scale(
                scale: 0.4,
                child: Lottie.asset(Assets.lotties.loading),
              ),
            ),
          ))),
    );
  }
}
/* Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imgSrc), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: width,
      child: Stack(
        children: [
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              width: 96,
              height: 36,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      'مشاهده',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 36,
                    child: Transform.scale(
                        scale: 0.6,
                        child: SvgPicture.asset(Assets.icons.arrowLeft)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xff343434),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          )
        ],
      ),
    ); */
