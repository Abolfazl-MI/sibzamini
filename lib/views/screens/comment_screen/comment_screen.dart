import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:sibzamini/controller/detail/detail_controller.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/models/comment_model/comment_model.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';
import 'package:sibzamini/views/global/widgets/custome_shimmerh_loading.dart';
import 'package:sibzamini/views/global/widgets/search_bar_widget.dart';
import 'package:sibzamini/views/global/widgets/select_location_widget.dart';
import 'package:sibzamini/views/screens/registration/regestration_inputs_widget.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final controller=Get.find<DetailController>();
    return Scaffold(
      backgroundColor: SolidColors.backGroundColor,
      body: GetBuilder<DetailController>(builder: (dController) {
        print(dController.salonComments);
        return Shimmer(
          linearGradient: shimmerGradient,
          child: ShimmerLoading(
            isLoading: dController.isCommentLoading,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SearchBarWidget(),
                ),
                SliverToBoxAdapter(
                  child: SelectLocationWidget(),
                ),
                // Salain name
                SliverToBoxAdapter(
                    child: Container(
                  padding: EdgeInsets.all(10),
                  width: width,
                  height: height * 0.02,
                )),
                SliverToBoxAdapter(
                  child:

                      /// [user comment sending section ]
                      Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'نظرات شما',
                          style: AppTextTheme.captionBold,
                        ),

                        ///[rating section]
                        Row(
                          children: [
                            Text(
                              'امتیاز شما به این سالن',
                              style: AppTextTheme.captionBold,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            RatingBar.builder(
                              initialRating: controller.rateToSalon,
                              allowHalfRating: false,
                              minRating: 1,
                              itemSize: 20,
                              itemCount: 5,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: SolidColors.yellow,
                              ),
                              onRatingUpdate: ((value) =>
                                  controller.updateRateForSalon(value)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            // Text(
                            //   controller.getOpinionBasedRatingCount(dController.getOpinionBasedRatingCount(dController.salonDetail?.id??0)) ?? '')
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        // feilds
                        // Text(
                        //   'نام نام خوانوادگی',
                        //   style: AppTextTheme.baseStyle
                        //       .copyWith(color: SolidColors.textColor5),
                        // ),
                        // AppInput(
                        //   keyboardType: TextInputType.name,
                        //   fillColor: Color(0xffF5F7FB),
                        //   controller: nameController,
                        //   hintTextstyle: AppTextTheme.subCaption.copyWith(
                        //       color: SolidColors.textColor5, fontSize: 15),
                        //   hintText: 'ابوالفضل مشهدی',
                        //   icon: Container(
                        //     child: Transform.scale(
                        //         scale: 0.5,
                        //         child: SvgPicture.asset(
                        //           Assets.icons.group,
                        //           color: SolidColors.primaryBlue,
                        //         )),
                        //   ),
                        // ),
                        SizedBox(
                          height: 5,
                        ),

                        // Text(
                        //   'ایمیل',
                        //   style: AppTextTheme.baseStyle
                        //       .copyWith(color: SolidColors.textColor5),
                        // ),
                        // AppInput(
                        //   keyboardType: TextInputType.emailAddress,
                        //   fillColor: Color(0xffF5F7FB),
                        //   controller: emailController,
                        //   hintTextstyle: AppTextTheme.subCaption.copyWith(
                        //       color: SolidColors.textColor5, fontSize: 15),
                        //   hintText: 'simbzamini@example.com',
                        //   icon: Container(
                        //     child: Transform.scale(
                        //         scale: 0.5,
                        //         child: SvgPicture.asset(Assets.icons.email2)),
                        //   ),
                        // ),
                        SizedBox(
                          height: 5,
                        ),

                        Text(
                          'پیام شما ',
                          style: AppTextTheme.baseStyle
                              .copyWith(color: SolidColors.textColor5),
                        ),

                        // buildTextField(
                        //   controller: controller.commentController,
                        //   hintText: 'پیام خود را اینجا بنویسید ',
                        //   // fillColor: SolidColors.textColor4
                        // ),
                        Container(
                          // margin: EdgeInsets.all(12),
                          height: 8 * 24.0,
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            controller: controller.commentController,
                            maxLines: 50,
                            decoration: InputDecoration(
                              hintStyle: AppTextTheme.subCaption.copyWith(
                                  color: SolidColors.textColor5, fontSize: 15),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: SolidColors.borderColor2)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: SolidColors.borderColor2)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: SolidColors.borderColor2)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: SolidColors.borderColor2)),
                              hintText: 'پیام خود را اینجا بنویسید ',
                              fillColor: SolidColors.darkGrey,
                              filled: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            if (controller.commentController.text == null ||
                                controller.commentController.text.isEmpty) {
                              Get.snackbar('\u{1F610}' 'مشکلی پیش آمده',
                                  'پر کردن بخش نظر الزامی است',
                                  backgroundColor: Colors.red);
                            }
                            if (dController.rateToSalon == 0) {
                              Get.snackbar('\u{1F610}' 'مشکلی پیش آمده',
                                  'حداقل یک ستاره برای امتیاز الزامی',
                                  backgroundColor: Colors.red);
                            }
                            if (controller.commentController.text != null &&
                                controller.commentController.text.isNotEmpty &&
                                dController.rateToSalon != null &&
                                dController.rateToSalon > 0) {
                              controller.sendComment(
                                  comment: controller.commentController.text.trim(),
                                  rate: dController.rateToSalon.toInt(),context: context);
                            }
                          },
                          child: SizedBox(
                            width: 120,
                            height: 50,
                            child: Card(
                              color: SolidColors.primaryBlue,
                              child: Center(
                                  child: Text(
                                'ارسال',
                                style: AppTextTheme.captionBold
                                    .copyWith(color: Colors.white),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                if (dController.salonComments == null ||
                    dController.salonComments!.isEmpty) ...[
                  SliverToBoxAdapter(
                      child: Container(
                          width: width,
                          // height:height*0.3,
                          // color:Colors.red,
                          child: Column(
                            children: [
                              Text('نظری وجود ندارد اولین باشید',
                                  style: AppTextTheme.caption),
                              Transform.scale(
                                  scale: 0.7,
                                  child:
                                      SvgPicture.asset(Assets.icons.notFind)),
                            ],
                          ))),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 80,
                    ),
                  ),
                ],
                if (dController.salonComments != null &&
                    dController.salonComments!.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'نظرات ',
                                  style: AppTextTheme.caption,
                                  children: [
                                    /// [comment count should get from server]
                                    TextSpan(
                                        text: dController.salonDetail!.rate
                                            .toString(),
                                        style: AppTextTheme.captionBold
                                            .copyWith(
                                                color: SolidColors.primaryBlue))
                                  ]),
                            ),
                            Row(
                              children: [
                                ///[salon all comments  gets from server]
                                Text(
                                  dController.getOpinionBasedRatingCount(
                                      dController.salonDetail!.id!),
                                  style: AppTextTheme.captionBold,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: SolidColors.darkGrey,
                                      border: Border.all(
                                          color: SolidColors.borderColor2),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      /// [all rating count from server]

                                      RatingStars(
                                        editable: false,
                                        iconSize: 18,
                                        rating: 3,
                                        color: SolidColors.yellow,
                                      ),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: SolidColors.primaryBlue,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            '3'.toPersianDigit(),
                                            style: AppTextTheme.captionBold
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // contunee form here
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: dController.salonComments!.length,
                        (context, index) {
                      Comment indexComment = dController.salonComments![index];
                      return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: SolidColors.borderColor2)),
                            color: Colors.white),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            /// [OTHER USER INFO AND RATING SECTION ]
                            Row(
                              children: [
                                CircleAvatar(
                                  maxRadius: 25,
                                  backgroundColor: SolidColors.darkGrey,
                                  child: Center(
                                    child: Transform.scale(
                                      scale: 0.9,
                                      child:
                                          SvgPicture.asset(Assets.icons.group),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      indexComment.name!,
                                      style: AppTextTheme.captionBold,
                                    ),
                                    Row(
                                      children: [
                                        RatingStars(
                                          iconSize: 18,
                                          rating:
                                              indexComment.score!.toDouble(),
                                          editable: false,
                                          color: SolidColors.yellow,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(dController
                                            .getOpinionBasedRatingCount(
                                                indexComment.score!))
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: width,
                              padding: EdgeInsets.all(15),
                              child: Text(
                                indexComment.comment!,
                                // 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد کتابهای زیادی در شصت و سه درصد گذشته حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد ',
                                textAlign: TextAlign.justify,
                                style: AppTextTheme.baseStyle
                                    .copyWith(color: SolidColors.textColor5),
                              ),
                              decoration: BoxDecoration(
                                  color: SolidColors.darkGrey,
                                  border: Border.all(
                                      color: SolidColors.borderColor2),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}

/* 
 */
/* myWidget() {
  double width = 100;
  double height = 100;
  return Column(
    children: [
      SearchBarWidget(),
      SelectLocationWidget(),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// [BrandName]
              Container(
                padding: EdgeInsets.all(10),
                width: width,
                height: height * 0.05,
                color: SolidColors.darkGrey,
                // color: Colors.red,
                // // todo shoud change format coresponding to server
                // child: Text(
                //   'اسم برند/خدمات پوست/سالن ایمان',
                //   style: AppTextTheme.caption
                //       .copyWith(fontSize: 18, color: SolidColors.textColor4),
                // ),
              ),

              /// [others comments]
              ///
              SizedBox(
                height: 20,
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: width,
                // height: height*0.8,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'نظرات ',
                              style: AppTextTheme.caption,
                              children: [
                                /// [comment count should get from server]
                                TextSpan(
                                    text: '3'.toPersianDigit(),
                                    style: AppTextTheme.captionBold.copyWith(
                                        color: SolidColors.primaryBlue))
                              ]),
                        ),
                        Row(
                          children: [
                            ///[salon all comments  gets from server]
                            Text(
                              'متوسط',
                              style: AppTextTheme.captionBold,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: SolidColors.darkGrey,
                                  border: Border.all(
                                      color: SolidColors.borderColor2),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  /// [all rating count from server]

                                  RatingStars(
                                    editable: false,
                                    iconSize: 18,
                                    rating: 3,
                                    color: SolidColors.yellow,
                                  ),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: SolidColors.primaryBlue,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        '3'.toPersianDigit(),
                                        style: AppTextTheme.captionBold
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // contunee form here
                      ],
                    ),

                    ///[other users comments section ]
                    Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: SolidColors.borderColor2)),
                                // color: SolidColors.darkGrey,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  /// [OTHER USER INFO AND RATING SECTION ]
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 25,
                                        backgroundColor: SolidColors.darkGrey,
                                        child: Center(
                                          child: Transform.scale(
                                            scale: 0.9,
                                            child: SvgPicture.asset(
                                                Assets.icons.group),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ابوالفضل مشهدی',
                                            style: AppTextTheme.captionBold,
                                          ),
                                          Row(
                                            children: [
                                              RatingStars(
                                                iconSize: 18,
                                                rating: 3,
                                                editable: false,
                                                color: SolidColors.yellow,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('متوسط')
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width,
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد کتابهای زیادی در شصت و سه درصد گذشته حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد ',
                                      textAlign: TextAlign.justify,
                                      style: AppTextTheme.baseStyle.copyWith(
                                          color: SolidColors.textColor5),
                                    ),
                                    decoration: BoxDecoration(
                                        color: SolidColors.darkGrey,
                                        border: Border.all(
                                            color: SolidColors.borderColor2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    ],
  );
}
 */
