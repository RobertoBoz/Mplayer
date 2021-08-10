import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplayer/Modules/Home/VideoPlayer/Widget/MPControls.dart';
import 'package:video_player/video_player.dart';

import 'MediaPlayerCotroller.dart';


class MPlayer extends StatelessWidget {

  final MediaPlayerController controller;    
  MPlayer({ required this.controller});
  

  @override
  Widget build(BuildContext context) {    
    
    
    return  GetBuilder<MediaPlayerController>(
      init: this.controller,
      builder: (_) => AspectRatio(
        aspectRatio: 16/9,
        child: Container(
          color: Colors.black,  
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _.videoController.value.isInitialized ? AspectRatio(aspectRatio: 16/9, child: VideoPlayer(_.videoController)):Container(),
              Obx(

                (){
                if(_.loading){
                  return CircularProgressIndicator();
                }else if(_.error){
                  return Text("Error", style: TextStyle(color: Colors.white),);
                }else if (_.none){
                  return Container();
                }
                return MPControls();

              }),
              
            ],
          ),        
        ),
      )
    );
  }
}





