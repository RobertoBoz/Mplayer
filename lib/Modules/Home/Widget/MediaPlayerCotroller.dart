import 'package:get/get.dart';
import 'package:video_player/video_player.dart';


enum SourcesStatus {none,loading, loaded, error}

enum PlayingStatus {stopped,playing, paused}


class MediaPlayerController extends GetxController{

  Rx<SourcesStatus> _sourceStatus = SourcesStatus.none.obs;
  Rx<PlayingStatus> _playingStatus = PlayingStatus.stopped.obs;
  Rx<Duration> _position = Duration.zero.obs; 
  Rx<Duration> _sliderPosition = Duration.zero.obs; 
  Rx<Duration> _duration = Duration.zero.obs; 
  late VideoPlayerController _videoController;
  bool _sliderMoving = false; 
  RxBool _mute = false.obs;

  @override
  void onInit() {
    super.onInit();
     loadVideo(url: 'https://movietrailers.apple.com/movies/independent/unhinged/unhinged-trailer-1_h720p.mov');
    
  }

  @override
  void onClose() {
    _videoController.dispose();
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
      final durationvideo = _videoController.value.duration;    
      if(durationvideo != null && _duration.value.inSeconds != durationvideo.inSeconds){
        _duration.value = durationvideo;
      }
      _videoController.addListener(() {
        final position = _videoController.value.position;        
        _position.value = position;        
        if(!_sliderMoving){
          _sliderPosition.value = position;
        }
        if(_position.value.inSeconds >= durationvideo.inSeconds && _playingStatus.value != PlayingStatus.stopped){
          _playingStatus.value = PlayingStatus.stopped;          
        }
      });
      _sourceStatus.value = SourcesStatus.loaded;
      update();    
    }catch(e){
        _sourceStatus.value = SourcesStatus.error;
    }
  }

   Future<void> play() async{

    if(stopped || paused){
      if(stopped){
        await _videoController.seekTo(Duration.zero);
      }
      _playingStatus.value = PlayingStatus.playing;
      await _videoController.play();
      

    }

   

  }

  Future<void> pause() async{
    if(playing){
       _playingStatus.value = PlayingStatus.paused;
      await _videoController.pause();
     
    }
  }

  

  Future<void> fastForward () async{

   final to = position.inSeconds + 10; 
   print(to);
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
    print('cambiando');

    _sliderMoving = false;
    if(stopped){
      _playingStatus.value = PlayingStatus.playing;
    }

  }

  Future<void> onMute() async{
    _mute.value = !_mute.value;
    _videoController.setVolume(mute ? 0 : 1);    
  }


  bool get none {
    print(_sourceStatus.value);
    return _sourceStatus.value == SourcesStatus.none;
  }
  bool get loading {
    print(_sourceStatus.value);
    return _sourceStatus.value == SourcesStatus.loading;
  }
  bool get loaded {
    print(_sourceStatus.value);
    return _sourceStatus.value == SourcesStatus.loaded;
  }
  bool get error {
    print(_sourceStatus.value);
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
  Duration get position => _position.value; 
  Duration get sliderPosition => _sliderPosition.value; 
  Duration get duration => _duration.value;   
  SourcesStatus get sourceStatus => _sourceStatus.value;
  VideoPlayerController get videoController => _videoController;


}