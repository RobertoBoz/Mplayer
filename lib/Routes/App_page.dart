import 'package:get/get.dart';

import 'App_Routes.dart';
import '/Modules/Home/Home_Export.dart';


class AppPages {
  static final List<GetPage> pages = [    
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
