import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/views.dart';

class SliderHeader extends StatelessWidget {
  final String rightText;
  final String leftText;
  final Function() onTap;
  const SliderHeader({Key? key, required this.rightText, required this.leftText, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            rightText,
            style: AppTextTheme.caption,
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              child: Row(
                children: [
                  Text(
                    leftText,
                    style: AppTextTheme.caption
                        .copyWith(color: SolidColors.primaryBlue),
                  ),
                  SvgPicture.asset(
                    Assets.icons.arrowBackThinBlue,
                    color: SolidColors.primaryBlue,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
