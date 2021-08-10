import 'package:get/get.dart';
import 'package:mplayer/Modules/Home/Home_Controller.dart';

class HomeBinding extends Bindings{
  
  @override
  void dependencies() => Get.lazyPut(() => HomeController());

}