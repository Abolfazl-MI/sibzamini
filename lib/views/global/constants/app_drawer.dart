import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibzamini/controller/controller.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/global.dart';

ButtonStyle _style = ButtonStyle(
  overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
);

class AppDrawer extends GetView<HomeController> {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SizedBox(
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
                // mainAxisAlignment: Main,
                children: [
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.scale(
                      scale: 1,
                      child: Image.asset(Assets.icons.logo.path),
                    ),
                  )),
                  Divider(color: SolidColors.textColor4),
                  // SizedBox(height: 5),
                  // Container(
                  //   height: 80,
                  //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Icon(Icons.groups_outlined,
                  //               size: 28, color: SolidColors.textColor4),
                  //           SizedBox(width: 10),
                  //           Text(
                  //             'پربازدید ترین سالن ها',
                  //             style: AppTextTheme.caption,
                  //           ),
                  //         ],
                  //       ),
                  //       // SizedBox(width: 40),

                  //       Row(
                  //         children: [
                  //           Icon(Icons.discount_outlined,
                  //               size: 28, color: SolidColors.textColor4),
                  //           SizedBox(width: 10),
                  //           Text(
                  //             'سالن های پر تخفیف',
                  //             style: AppTextTheme.caption,
                  //           ),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  //   // color: Colors.yellow,
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Divider(color: SolidColors.textColor4),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'دسته بندی خدمات',
                            style: AppTextTheme.captionBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                      itemCount: controller.salonCategories.length + 1,
                      shrinkWrap: true,
                      itemBuilder: ((contex, index) {
                        if (index == controller.salonCategories.length) {
                          return Container(
                            child:Row(
                              children: [
                                TextButton(
                            onPressed: () {},
                            child: Text('همه',
                                style: AppTextTheme.caption.copyWith(
                                    color: SolidColors.textColor4,
                                    fontSize: 17)),
                          )
                              ],
                            )
                          );
                        }
                        return Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                controller.getSalonByCategories(category: controller.salonCategories[index]);
                                // controller.getSalonByCategories(category: category)
                                // controller.getSalonByCategories(category: controller.salonsBasedOnCategory);
                              },
                              child: Text(
                                  controller.salonCategories[index].name!,
                                  style: AppTextTheme.caption.copyWith(
                                      color: SolidColors.textColor4,
                                      fontSize: 17)),
                            )
                          ],
                        );
                      }),
                    ),
                  )
                ],
              ))),
    );
  }
}
/* Column(
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
 */
