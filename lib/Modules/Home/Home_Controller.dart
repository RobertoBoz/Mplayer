import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:mplayer/Data/Models/VideoModel.dart';
import 'package:mplayer/Data/Providers/Remote/ApiServiceVideoPlayer.dart';
import 'package:mplayer/Data/Repositories/ApiRepositoryVideoPlayer.dart';

import 'package:mplayer/Modules/Home/VideoPlayer/MediaPlayerCotroller.dart';




enum SourcesStatus {none,loading, loaded, error}

enum PlayingStatus {stopped,playing, paused}


class HomeController extends GetxController{

  ApiServiceVideoPlayer _api = new ApiServiceVideoPlayer();
  List<Video> _videoList = [];
  
  List<Video> get videoList => _videoList;

   MediaPlayerController _mplayerController =  MediaPlayerController();
  // ignore: unnecessary_getters_setters
  MediaPlayerController get  mplayerController => _mplayerController;

  // ignore: unnecessary_getters_setters
  // set mplayerController (MediaPlayerController  controller) {
  //   _mplayerController = controller;
  // }

  

  

  @override
  void onInit() {
    super.onInit();      


     _mplayerController.loadVideo(url: 'https://movietrailers.apple.com/movies/paramount/the-spongebob-movie-sponge-on-the-run/the-spongebob-movie-sponge-on-the-run-big-game_h720p.mov');
    
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

  void loadnewVideo(String url) async {

    _mplayerController.dispose();
    _mplayerController.onClose();
    _mplayerController = MediaPlayerController();
    print(url);
    mplayerController.loadVideo(url: url);
    update();

  }







}