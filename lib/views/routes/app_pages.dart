import 'package:get/route_manager.dart';
import 'package:sibzamini/controller/all_salons_controller/all_salons_binding.dart';
import 'package:sibzamini/controller/bookMark_controller/bookMark_binding.dart';

import 'package:sibzamini/controller/controller.dart';
import 'package:sibzamini/controller/detail/detail_biding.dart';
import 'package:sibzamini/controller/searchSalon/search_salon_binding.dart';
import 'package:sibzamini/controller/splash/splash_binding.dart';
import 'package:sibzamini/views/screens/book_marked_salons/book_marked_salons.dart';
import 'package:sibzamini/views/screens/favorite_salon/favorite_salons_screen.dart';
import 'package:sibzamini/views/screens/location_screen/location_screen.dart';
import 'package:sibzamini/views/screens/registration/signup_screen.dart';
import 'package:sibzamini/views/screens/search_salon/search_salons.dart';
import 'package:sibzamini/views/views.dart';

import '../screens/show_all_salon_screen/show_all_salons.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
        name: rSplashScreen,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: rLoginScreen,
        page: () => RegistrationScreen(),
        binding: RegistrationBinding()),
    GetPage(
      name: rSignUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
        name: rVerifyCodeScreen,
        page: () => VerifyCodeScreen(),
        binding: RegistrationBinding()),
    GetPage(
        name: rHomeScreen, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(
        name: rDetailScreen,
        page: () => DetailScreen(),
        binding: DetailBiding()),
    GetPage(
        name: rCommentsScreen,
        page: () => CommentScreen(),
        binding: DetailBiding()),
    GetPage(
      name: rLocationScreen,
      page: () => LocationScreen(),
    ),
    GetPage(
      name: rErrorScreen,
      page: () => const ErrorScreen(),
    ),
    GetPage(
        name: rAllSalonsScreen,
        page: () => AllSalonsScreen(),
        binding: AllSalonsBinding()),
    GetPage(
        name: rSrarchSalons,
        page: () => SearchSalonsScreen(),
        binding: SearchSalonBinding()),
    GetPage(
        name: rFavSalonsScreen,
        page: () => FavoriteSalonScreen(),
        binding: BookMarkedSalonsBinding())
  ];
}
