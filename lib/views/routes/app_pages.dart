import 'package:get/route_manager.dart';
import 'package:sibzamini/controller/all_salons_controller/all_salons_binding.dart';
import 'package:sibzamini/controller/bookMark_controller/bookMark_binding.dart';

import 'package:sibzamini/controller/controller.dart';
import 'package:sibzamini/controller/detail/detail_biding.dart';
import 'package:sibzamini/controller/searchSalon/search_salon_binding.dart';
import 'package:sibzamini/controller/splash/splash_binding.dart';
import 'package:sibzamini/views/screens/favorite_salon/favorite_salons_screen.dart';
import 'package:sibzamini/views/screens/location_screen/location_screen.dart';
import 'package:sibzamini/views/screens/registration/signup_screen.dart';
import 'package:sibzamini/views/screens/search_salon/search_salons.dart';
import 'package:sibzamini/views/views.dart';

import '../screens/show_all_salon_screen/show_all_salons.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
        name: AppRoutes.rSplashScreen,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.rLoginScreen,
        page: () => RegistrationScreen(),
        binding: RegistrationBinding()),
    GetPage(
      name: AppRoutes.rSignUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
        name: AppRoutes.rVerifyCodeScreen,
        page: () => VerifyCodeScreen(),
        binding: RegistrationBinding()),
    GetPage(
        name: AppRoutes.rHomeScreen, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(
        name: AppRoutes.rDetailScreen,
        page: () => DetailScreen(),
        binding: DetailBiding()),
    GetPage(
        name: AppRoutes.rCommentsScreen,
        page: () => CommentScreen(),
        binding: DetailBiding()),
    GetPage(
      name: AppRoutes.rLocationScreen,
      page: () => LocationScreen(),
    ),
    GetPage(
      name: AppRoutes.rErrorScreen,
      page: () => const ErrorScreen(),
    ),
    GetPage(
        name: AppRoutes.rAllSalonsScreen,
        page: () => AllSalonsScreen(),
        binding: AllSalonsBinding()),
    GetPage(
        name: AppRoutes.rSrarchSalons,
        page: () => SearchSalonsScreen(),
        binding: SearchSalonBinding()),
    GetPage(
        name: AppRoutes.rFavSalonsScreen,
        page: () => FavoriteSalonScreen(),
        binding: BookMarkedSalonsBinding())
  ];
}
