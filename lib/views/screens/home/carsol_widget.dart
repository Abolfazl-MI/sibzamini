import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';

class CarsolWidget extends StatelessWidget {
  final String imgSrc;
  final double width;

  const CarsolWidget({super.key, required this.imgSrc, required this.width});
  @override
  Widget build(BuildContext context) {
    // throw UnimplementedError();
    return Container(
      decoration: BoxDecoration(

          // color: Colors.black26,
          image: DecorationImage(
              image: AssetImage(
                imgSrc
              ),
              fit: BoxFit.fill),
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
    );
  }
}
