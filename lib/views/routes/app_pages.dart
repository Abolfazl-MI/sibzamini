import 'package:get/route_manager.dart';

import 'package:sibzamini/controller/controller.dart';
import 'package:sibzamini/controller/detail/detail_biding.dart';
import 'package:sibzamini/views/screens/comment_screen/comment_screen.dart';
import 'package:sibzamini/views/screens/detail_screen/detail_screen.dart';
import 'package:sibzamini/views/screens/location_screen/location_screen.dart';
import 'package:sibzamini/views/views.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutesName.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: AppRoutesName.registrationScreen,
        page: () => RegistrationScreen(),
        binding: RegistrationBinding()),
    GetPage(
        name: AppRoutesName.verifyCodeScreen,
        page: () => VerifyCodeScreen(),
        binding: RegistrationBinding()),
    GetPage(
        name: AppRoutesName.homeScreen,
        page: () => HomeScreen(),
        binding: HomeBinding()),
    GetPage(
      name: AppRoutesName.detailScreen,
      page: () => DetailScreen(),
      binding: DetailBiding()
      
    ),
    GetPage(
      name: AppRoutesName.commentsScreen,
      page: () => CommentScreen(),
      
    ),
    GetPage(
      name: AppRoutesName.locationScreen,
      page: () => LocationScreen(),
      
    )
  ];
}
