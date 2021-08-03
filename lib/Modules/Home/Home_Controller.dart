import 'package:get/get.dart';

import 'package:mplayer/Data/Models/VideoModel.dart';

import 'package:mplayer/Data/Providers/Remote/ApiServiceVideoPlayer.dart';
import 'package:mplayer/Data/Repositories/ApiRepositoryVideoPlayer.dart';




enum SourcesStatus {none,loading, loaded, error}

enum PlayingStatus {stopped,playing, paused}


class HomeController extends GetxController{

  ApiServiceVideoPlayer _api = new ApiServiceVideoPlayer();
  List<Video> _videoList = [];

  List<Video> get videoList => _videoList;

  

  

  @override
  void onInit() {
    super.onInit();
     
    
  }

  @override
  void onClose() {
    
   
    super.onClose();
  }

  @override
  void onReady() {
   

    loadvideolist();

   
    super.onReady();
  }


  void loadvideolist() async {

    ApiVideoPlayeRepository _playeRepository = new ApiVideoPlayeRepository(_api);
    _videoList = await _playeRepository.getAllVideos();
    update();
    
  }







}