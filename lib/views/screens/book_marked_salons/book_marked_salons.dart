

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sibzamini/gen/assets.gen.dart';
import 'package:sibzamini/views/global/constants/app_drawer.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';

class BookMarkedSalonsScreen extends StatefulWidget {
  const BookMarkedSalonsScreen({super.key});

  @override
  State<BookMarkedSalonsScreen> createState() => _BookMarkedSalonsScreenState();
}

class _BookMarkedSalonsScreenState extends State<BookMarkedSalonsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    // _scaffoldKey=
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        
        actions: [
          IconButton(
            icon:Icon(Icons.arrow_back_ios, color: Colors.grey,), 
            onPressed: (){
              Get.offNamed(rHomeScreen);
            },
          )
        ],
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset(Assets.icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        title: Transform.scale(
            scale: 0.8, child: SvgPicture.asset(Assets.icons.logos)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      
    );
  }
}