import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

enum SourcesStatus {none,loading, loaded, error}

enum PlayingStatus {stopped,playing, paused}


class  MediaPlayerController extends GetxController{


  Rx<SourcesStatus> _sourceStatus = SourcesStatus.none.obs;
  Rx<PlayingStatus> _playingStatus = PlayingStatus.stopped.obs;
  Rx<Duration> _position = Duration.zero.obs; 
  Rx<Duration> _sliderPosition = Duration.zero.obs; 
  Rx<Duration> _duration = Duration.zero.obs; 
  Rx<Duration> _bufferedLoaded = Duration.zero.obs;
  late VideoPlayerController _videoController;
  bool _sliderMoving = false; 
  RxBool _mute = false.obs;
  RxBool _fullscreen = false.obs;
  RxBool _showControls = true.obs;
  Timer _timer = Timer(Duration(seconds: 1), () {});


  @override
  void onInit() {
    super.onInit();  

    
  }

  @override
  void onClose() {
    
      _timer.cancel();
    
    
    super.onClose();
  }

  @override
  void onReady() {       
    super.onReady();
  }


  Future<void> loadVideo({required String url}) async{

    try{
      _playingStatus.value = PlayingStatus.paused;
      _sourceStatus.value = SourcesStatus.loading;


     
    

      _videoController = VideoPlayerController.network(url);

      await _videoController.initialize();    
      
      final duration = _videoController.value.duration;

      if (duration != null && _duration.value.inSeconds != duration.inSeconds) {
        _duration.value = duration;
      }
      _videoController.addListener(() {

        
        final position = _videoController.value.position;
        _position.value = position;

        if (!_sliderMoving) {
          _sliderPosition.value = position;
        }

        if (_position.value.inSeconds >= duration.inSeconds && !stopped) {
          _playingStatus.value = PlayingStatus.stopped;
        }

        _bufferedLoaded.value = _videoController.value.buffered.last.end;

      
      });
      _sourceStatus.value = SourcesStatus.loaded;
      update();    
      // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      //   if (tmp != null) {
      //     await tmp.dispose();
          
      //   }
      // });
    }catch(e){
        _sourceStatus.value = SourcesStatus.error;
    }
  }

   Future<void> play() async{
    if (stopped || paused) {
      if (stopped) {
        await seekTo(Duration.zero);
      }
      await _videoController.play();
      _playingStatus.value = PlayingStatus.playing;    
      _hideTaskControls();  
    }
  }

  Future<void> pause() async{
    if(playing){
       
      await _videoController.pause();
      _playingStatus.value = PlayingStatus.paused;
     
    }
  }

  

  Future<void> fastForward () async{

   final to = position.inSeconds + 10; 
   
   if (duration.inSeconds > to ){
      await seekTo(Duration(seconds: to));
   }
    
  }

  Future<void> seekTo( Duration position ) async{
    await _videoController.seekTo(position);
  } 
  
  Future<void> rewind () async{
    final to = position.inSeconds-10;
    await seekTo(Duration(seconds: (to < 0) ? 0 : to));
  }

  void onChange(double value){
    _sliderPosition.value = Duration(seconds: value.floor());
  }
  void onChangeStart(){
    _sliderMoving = true;
  }

  void onChangeEnd(){ 
    
    _sliderMoving = false;
     if (stopped) {
        _playingStatus.value = PlayingStatus.playing; 
      }
    
     
  }

  Future<void> onMute() async{
    _mute.value = !_mute.value;
    update(['mute']);
    _videoController.setVolume(mute ? 0 : 1);    
  }

  Future<void> onFullScreen() async{
    _fullscreen.value = !_fullscreen.value;
    if(fullscreen){
      await SystemChrome.setEnabledSystemUIOverlays([]);     
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ]
      );
      
    }else{
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
       await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
       
      ]
      );
    }

    update(['fullscreen']);     
  }

   onShowControls() {
    _showControls.value = !_showControls.value;   
    if (showControls) {
      _hideTaskControls();
    }
  }

  void _hideTaskControls() {
    _timer = Timer(Duration(seconds: 5), () {
      onShowControls();
      
    });
  }



  bool get none {    
    return _sourceStatus.value == SourcesStatus.none;
  }
  bool get loading {    
    return _sourceStatus.value == SourcesStatus.loading;
  }
  bool get loaded {    
    return _sourceStatus.value == SourcesStatus.loaded;
  }
  bool get error {    
    return _sourceStatus.value == SourcesStatus.error;
  }

  bool get playing {
    return _playingStatus.value == PlayingStatus.playing;
  }

  bool get stopped {
    return _playingStatus.value == PlayingStatus.stopped;
  }

  bool get paused {
    return _playingStatus.value == PlayingStatus.paused;
  }

  bool get mute  => _mute.value;
  bool get showControls  => _showControls.value;
  bool get fullscreen  => _fullscreen.value;
  Duration get position => _position.value; 
  Duration get sliderPosition => _sliderPosition.value; 
  Duration get duration => _duration.value;   
  Duration get bufferedLoaded => _bufferedLoaded.value;   
  SourcesStatus get sourceStatus => _sourceStatus.value;
  VideoPlayerController get videoController => _videoController;


}