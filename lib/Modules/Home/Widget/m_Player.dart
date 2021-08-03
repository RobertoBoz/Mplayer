import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplayer/Utils/Helper.dart';
import 'package:video_player/video_player.dart';

import 'MediaPlayerCotroller.dart';

class MPlayer extends StatelessWidget {
  
  final _controller = MediaPlayerController();

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<MediaPlayerController>(
      init: _controller,
      builder: (_) => AspectRatio(
        aspectRatio: 16/9,
        child: Container(
          color: Colors.black,  
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _.videoController.value.isInitialized ? VideoPlayer(_.videoController):Container(),
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


class MPControls extends StatelessWidget {

  const MPControls({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<MediaPlayerController>(
      builder: (_) => Positioned.fill(
        child:  Container(
          width: double.infinity,
          color: Colors.black26,  
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ButtonControlsVideo(iconUrl: 'assets/icons/rewind.png', size: 50,onPressed: _.rewind,),
                  SizedBox(width: 20,),
                  Obx((){
                    if(_.playing){
                      return ButtonControlsVideo(iconUrl: 'assets/icons/pause.png', size: 60,onPressed: _.pause);
                    }else if(_.paused) {
                      return ButtonControlsVideo(iconUrl: 'assets/icons/play.png', size: 60,onPressed: _.play);
                    }
                    return ButtonControlsVideo(iconUrl: 'assets/icons/repeat.png', size: 60,onPressed: _.play);
                  }),                  
                  SizedBox(width: 20,),
                  ButtonControlsVideo(iconUrl: 'assets/icons/fast-forward.png', size: 50,onPressed: _.fastForward),
                ],
              )
              ,
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,                
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Obx(() => Text(Helper().parceDuration(_.position),style: TextStyle(color: Colors.white),)),
                      MSlider(),
                      ButtonControlsVideo(
                        iconColor: Colors.white,
                        background: Colors.transparent,
                        iconUrl: _.mute ? 'assets/icons/mute.png' : 'assets/icons/sound.png',                        
                        onPressed: _.fastForward,
                        size: 30,
                        circle: false,
                      ),
                      SizedBox(width: 10,),
                      Obx(() => Text(Helper().parceDuration(_.duration),style: TextStyle(color: Colors.white),)),
                    ],
                  ),
                ),
              )
          
            ],
          
          ),          
        ),
      )
      
    );
  }
}

class MSlider extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MediaPlayerController>(
      builder: (_) => Expanded(
        child: Obx((){
          return 
          (_.sliderPosition.inSeconds < _.duration.inSeconds || _.duration.inSeconds >= 0 ) ? 
          Slider(
            value: _.sliderPosition.inSeconds.toDouble(),
            min: 0, 
            onChangeEnd: (v){
              _.onChangeEnd();
              _.seekTo(Duration(seconds: v.floor()));
            },
            onChangeStart: (v){
              _.onChangeStart();
            },            
            divisions: _.duration.inSeconds,
            label: Helper().parceDuration(_.sliderPosition),
            max: _.duration.inSeconds.toDouble(),
            onChanged: _.onChange
          ) : Container();
        })
      )
    );
  }
}

class ButtonControlsVideo extends StatelessWidget {
  
  final double size;
  final String iconUrl; 
  final VoidCallback onPressed;
  final bool circle;
  final Color background;
  final Color iconColor;

  ButtonControlsVideo({ this.size = 40 , required this.iconUrl, required this.onPressed, this.circle = true, this.background = Colors.white54, this.iconColor = Colors.black });
 
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        width: this.size,
        height: this.size,
        padding: EdgeInsets.all(this.size * 0.20),
        decoration: BoxDecoration(
          color: this.background,
          shape: this.circle ? BoxShape.circle : BoxShape.rectangle
        ),
        child: Image.asset(this.iconUrl,color: this.iconColor,),

      ), 
      onPressed: () => onPressed()
    );
  }
}