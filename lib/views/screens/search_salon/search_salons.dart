import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/models/cities_model/cities_model.dart';
import 'package:sibzamini/services/local/connectivity_service.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sibzamini/controller/searchSalon/search_salon_controller.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';
import 'package:sibzamini/views/global/constants/genral_input_decoration.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';
import 'package:sibzamini/views/screens/home/bottomshets/fav_salon_bottom_sheet.dart';
import 'package:sibzamini/views/screens/home/bottomshets/select_city_location_bottom_sheet.dart';

class SearchSalonsScreen extends StatelessWidget {
  const SearchSalonsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: SolidColors.backGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: SvgPicture.asset(Assets.icons.menu),
        centerTitle: true,
        title: Transform.scale(
            scale: 0.8, child: SvgPicture.asset(Assets.icons.logos)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body:GetBuilder<SearchSalonsController>(
        builder:(controller){
          if(controller.connectivityStatus==ConnectivityStatus.connected){
            return Column(
              children: [
                _searchBar(width: width, height: height, context: context), 
                _selectLocationSection(width, context),
                _mostSeachedTitle(width), 
              //  TODO use slider list for top searced salons

              ],
            );
          }
          return  Container(
            child: Center(
                child:Text('abolfaz')
            )
          );
        }
      ) ,
    );
  }
  _searchBar({required double width, required double height, required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: SolidColors.borderColor))),
      // padding: EdgeInsets.symmetric(
      //   horizontal: 16,
      // ),
      width: width,
      height: 56,

      // color: Colors.green,
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Get.offNamed(rSrarchSalons);
                },
                child: SizedBox(
                  // height: 32,
                  child: TextFormField(
                    textAlign: TextAlign.justify,
                    autofocus: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: SolidColors.borderColor,
                        hintStyle: TextStyle(
                            fontSize: 12, color: SolidColors.textColor4),
                        hintText: 'دنبال‌چی‌میگردی؟',
                        enabledBorder: genralInputDecoration,
                        // enabled: false,

                        disabledBorder: genralInputDecoration,
                        focusedBorder: genralInputDecoration,
                        prefixIcon: IconButton(
                          icon: SvgPicture.asset(
                            Assets.icons.search,
                            color: SolidColors.textColor4,
                          ),
                          onPressed: () => null,
                        )),
                  ),
                ),
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: SvgPicture.asset(Assets.icons.group),
          // ),
          IconButton(
            onPressed: () {
              showFavSalonBottomSheet(context);
            },
            icon: SvgPicture.asset(Assets.icons.heart),
          ),
        ],
      ),
    );
  }
  _selectLocationSection(
      double width,
      BuildContext context,
      ) {
    return InkWell(
      onTap: () {
        // showCityLocationBottemSheet(
        //     context, width, Get.find<HomeController>().availableCities);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: SolidColors.borderColor,
            ),
          ),
        ),
        width: width,
        height: 36,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: null,
                  icon: SvgPicture.asset(Assets.icons.location),
                ),
                Text(
                  'تغییر شهر',
                  style: TextStyle(color: SolidColors.textColor4),
                ),
              ],
            ),
            IconButton(
              onPressed: null,
              icon: SvgPicture.asset(
                Assets.icons.arrowBackFiiled,
                color: SolidColors.textColor4,
              ),
            )
          ],
        ),
      ),
    );
  }
  _changeCityLoacation(double width,BuildContext context,List<City>cities,){
    return showModalBottomSheet(isScrollControlled: true,context: context, shape: const RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(25.0))), builder: (context) => Container(
      width: width,
      height: MediaQuery.of(context).size.height / 1.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: InkWell(
                onTap: () {
                  // TODO IMPL THE AUTOMATIC LOCATION
                },
                child: Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(Assets.icons.locationSearch),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'مکان‌یا‌بی‌خودکار',
                        style: AppTextTheme.caption
                            .copyWith(color: SolidColors.primaryBlue),
                      )
                    ],
                  ),
                ),
              ),
            ),
            cities.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: cities.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: ((context, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: SolidColors.textColor4))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 12),
                    child: TextButton(
                      onPressed: () {

                      },
                      child: Text(cities[index].name ?? '',
                          style: AppTextTheme.caption.copyWith(
                              color: SolidColors.textColor4)),
                    ),
                  ),
                )),
              ),
            )
                : Expanded(
              // width:width,
              child: Column(children: [
                Transform.scale(
                    scale: 0.5,
                    child: SvgPicture.asset(Assets.icons.notFind)),
                Text('موردی پیدا نشد بعدا تلاش کنید')
              ]),
            )
          ],
        ),
      ),
    ));
  }

  _mostSeachedTitle(double width) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical:10),
      child: Row(
        children:[
          Icon(Icons.local_fire_department_outlined),
          Text('سالن های برتر', style:AppTextTheme.captionBold)
        ]
      ),
    );
  }

  // _mostSerchedSalons(double width) {}
}
