import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/global.dart';

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

ButtonStyle _style = ButtonStyle(
  overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
);

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        width: width / 1.5,
        height: height / 1.001,
        child: Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SvgPicture.asset(Assets.icons.logos),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  height: 0.8,
                  color: SolidColors.textColor4,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: _style,
                  onPressed: () {},
                  child: Text(_drawerText[0],
                      style: AppTextTheme.caption.copyWith(
                          color: SolidColors.textColor4, fontSize: 17)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: _style,
                  onPressed: () {},
                  child: Text(_drawerText[1],
                      style: AppTextTheme.caption.copyWith(
                          color: SolidColors.textColor4, fontSize: 17)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: _style,
                  onPressed: () {},
                  child: Text(_drawerText[2],
                      style: AppTextTheme.caption.copyWith(
                          color: SolidColors.textColor4, fontSize: 17)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  onPressed: () {},
                  child: Text(_drawerText[3],
                      style: AppTextTheme.caption.copyWith(
                          color: SolidColors.textColor4, fontSize: 17)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: _style,
                  onPressed: () {},
                  child: Text(_drawerText[4],
                      style: AppTextTheme.caption.copyWith(
                          color: SolidColors.textColor4, fontSize: 17)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: _style,
                  onPressed: () {},
                  child: Text(_drawerText[5],
                      style: AppTextTheme.caption.copyWith(
                          color: SolidColors.textColor4, fontSize: 17)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: _style,
                  onPressed: () {},
                  child: Text(_drawerText[6],
                      style: AppTextTheme.caption.copyWith(
                          color: SolidColors.textColor4, fontSize: 17)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: _style,
                  onPressed: () {},
                  child: Text(_drawerText[7],
                      style: AppTextTheme.caption.copyWith(
                          color: SolidColors.textColor4, fontSize: 17)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
