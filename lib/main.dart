import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'Modules/Home/Home_Export.dart';
import 'Routes/App_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MplayerPrueba',
      home: HomePage(),
      initialBinding: HomeBinding(),
      getPages: AppPages.pages,
      
    );
  }
}



