import 'package:get/route_manager.dart';
import 'package:sibzamini/controller/controller.dart';

import 'package:sibzamini/views/views.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutesName.registrationScreen,
      page: () => RegistrationScreen(),
      binding: RegistrationBinding()
    ),
    GetPage(
      name: AppRoutesName.verifyCodeScreen,
      page: () => VerifyCodeScreen(),
      binding: RegistrationBinding()

    )
  ];
}
