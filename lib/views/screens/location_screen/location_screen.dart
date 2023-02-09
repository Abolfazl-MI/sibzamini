import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapir_raster/mapir_raster.dart';
import 'package:sibzamini/controller/detail/detail_controller.dart';
import 'package:sibzamini/views/global/colors/colors.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';
import 'package:sibzamini/views/global/constants/map_token.dart';
import 'package:sibzamini/views/global/widgets/search_bar_widget.dart';
import 'package:sibzamini/views/global/widgets/select_location_widget.dart';

class LocationScreen extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: SolidColors.backGroundColor,
        body: Column(
          children: [
            SearchBarWidget(),
            // SelectLocationWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// [BrandName]
                    // Container(
                    //   padding: EdgeInsets.all(10),
                    //   width: width,
                    //   height: height * 0.05,
                    //   color: SolidColors.darkGrey,

                    //   // color: Colors.red,
                    //   // // todo shoud change format coresponding to server
                    //   // child: Text(
                    //   //   'اسم برند/خدمات پوست/سالن ایمان',
                    //   //   style: AppTextTheme.caption.copyWith(
                    //   //       fontSize: 18, color: SolidColors.textColor4),
                    //   // ),
                    // ),

                    GetBuilder<DetailController>(builder: (detailController) {
                      // print(detailController.salonDetail!.lat);
                      // print(detailController.salonDetail!.lng);

                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        // color: Colors.amber,
                        child: MapirMap(
                          apiKey: map_token,
                          options: MapOptions(
                            center: LatLng(detailController.salonDetail!.lat!,
                                detailController.salonDetail!.lng!),
                          ),
                          layers: [
                            MarkerLayerOptions(markers: [
                              Marker(
                                  point: LatLng(
                                      detailController.salonDetail!.lat!,
                                      detailController.salonDetail!.lng!),
                                  builder: (ctx) => Icon(
                                        Icons.location_on_outlined,
                                        size: 50,
                                        color: Colors.red,
                                      ))
                            ])
                          ],
                        ),
                      );
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   width: width,
                    //   // height: 100,
                    //   color: Colors.white,
                    //   child: Column(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(18.0),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             Text(
                    //               'آدرس' ':',
                    //               style: AppTextTheme.captionBold,
                    //             ),
                    //             GetBuilder<DetailController>(
                    //               builder:(detailController)=> Text(
                    //                 detailController.salonDetail?.address??'',
                    //                 style: AppTextTheme.caption
                    //                     .copyWith(color: SolidColors.textColor4),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.all(5.0),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             Text(
                    //               'آدرس' ':',
                    //               style: AppTextTheme.captionBold,
                    //             ),
                    //             GetBuilder<DetailController>(
                    //               builder:(detailController)=> Text(
                    //                 detailController.salonDetail?.address??'',
                    //                 style: AppTextTheme.caption
                    //                     .copyWith(color: SolidColors.textColor4),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //  Row(
                    //           crossAxisAlignment: CrossAxisAlignment.end,
                    //           mainAxisAlignment: MainAxisAlignment.end,
                    //           )
                    //     ],
                    //   ),
                    // )
                    Container(
                      padding: EdgeInsets.all(18),
                      width: width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'آدرس' ':',
                                style: AppTextTheme.captionBold,
                              ),
                              SizedBox(width: 5),
                              GetBuilder<DetailController>(
                                builder: (detailController) => Text(
                                  detailController.salonDetail?.address ?? '',
                                  style: AppTextTheme.caption
                                      .copyWith(color: SolidColors.textColor3),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'شماره تلفن' ':',
                                style: AppTextTheme.captionBold,
                              ),
                              SizedBox(width: 5),
                              GetBuilder<DetailController>(
                                  builder: (detailController) => TextButton(
                                      child: Text(
                                        detailController.salonDetail?.mobile ??
                                            '',
                                        style: AppTextTheme.caption.copyWith(
                                            color: SolidColors.primaryBlue),
                                      ),
                                      onPressed: () => detailController
                                          .openDailer(detailController
                                              .salonDetail!.mobile
                                              .toString())))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'شماره ثابت' ':',
                                style: AppTextTheme.captionBold,
                              ),
                              SizedBox(width: 5),
                              GetBuilder<DetailController>(
                                builder: (detailController) => TextButton(
                                    onPressed: ()=>detailController.openDailer(detailController.salonDetail!.phone.toString()),
                                    child: Text(
                                      detailController.salonDetail?.phone ?? '',
                                      style: AppTextTheme.caption.copyWith(
                                          color: SolidColors.primaryBlue),
                                    )),
                              )
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       'شماره تلفن' ':',
                          //       style: AppTextTheme.captionBold,
                          //     ),
                          //     SizedBox(width: 5),
                          //     GetBuilder<DetailController>(
                          //       builder: (detailController) => Text(
                          //         detailController.salonDetail?.phone ?? '',
                          //         style: AppTextTheme.caption
                          //             .copyWith(color: SolidColors.textColor3),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GetBuilder<DetailController>(
                                  builder: (detailContoller) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        detailContoller.launchMApUrl(
                                          detailContoller.salonDetail!.lat!,
                                          detailContoller.salonDetail!.lng!,
                                        );
                                      },
                                      // onTap: ()=>controller.launchMApUrl(lat, lon),
                                      child: Row(
                                        children: [
                                          Text(
                                            'بازکردن نقشه',
                                            style: AppTextTheme.captionBold
                                                .copyWith(
                                                    fontSize: 18,
                                                    color: SolidColors
                                                        .primaryBlue),
                                          ),
                                          Icon(
                                            Icons.arrow_back_ios_new,
                                            color: SolidColors.primaryBlue,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ])
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
