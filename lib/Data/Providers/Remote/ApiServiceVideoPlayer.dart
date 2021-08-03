

import 'package:mplayer/Data/Models/VideoModel.dart';
import 'package:mplayer/Utils/VideoList.dart';

class ApiServiceVideoPlayer {


  Future<List<Video>> getAllVideosRepository() async {
    
    List<Video> video =  [];

    video = Constant().videos.map((e) => Video.fromJson(e)).toList();


    return  video;
  }


}