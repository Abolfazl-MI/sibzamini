import 'package:get/route_manager.dart';

import 'package:sibzamini/controller/controller.dart';
import 'package:sibzamini/controller/detail/detail_biding.dart';
import 'package:sibzamini/controller/splash/splash_binding.dart';
import 'package:sibzamini/views/screens/location_screen/location_screen.dart';
import 'package:sibzamini/views/screens/registration/signup_screen.dart';
import 'package:sibzamini/views/views.dart';

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
    GetPage(name: rErrorScreen, page: () => ErrorScreen())
  ];
}
