
import 'package:mplayer/Data/Models/VideoModel.dart';
import 'package:mplayer/Data/Providers/Remote/ApiServiceVideoPlayer.dart';

class ApiVideoPlayeRepository{

  final ApiServiceVideoPlayer _api;

  ApiVideoPlayeRepository(this._api);

  Future<List<Video>> getAllVideos() =>  _api.getAllVideosRepository();




}