
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../MediaPlayerCotroller.dart';
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

class MuteButton extends StatelessWidget {   
  @override
  Widget build(BuildContext context) {
    
    return  GetBuilder<MediaPlayerController>(
      id: 'mute',
      builder: (_) => ButtonControlsVideo(        
        iconColor: Colors.white,
        background: Colors.transparent,
        iconUrl: _.mute ? 'assets/icons/mute.png' : 'assets/icons/sound.png',                        
        onPressed: _.onMute,
        size: 30,
        circle: false,
      )
    );
  }
}

class FullScreenButton extends StatelessWidget {   
  @override
  Widget build(BuildContext context) {
    
    return  GetBuilder<MediaPlayerController>(
      id: 'fullscreen',
      builder: (_) => Obx((){
          return ButtonControlsVideo(        
            iconColor: Colors.white,
            background: Colors.transparent,
            iconUrl: _.fullscreen ?   'assets/icons/minimize.png' :'assets/icons/fullscreen.png',                        
            onPressed: _.onFullScreen,
            size: 30,
            circle: false,
          );
        }
      )
    );
  }
}


class ButtonMedialPlayer extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MediaPlayerController>(    
      builder: (_) => Obx(() {
      
        String iconPath = 'assets/icons/repeat.png';
        if (_.playing) {

          iconPath = 'assets/icons/pause.png';

        } else if (_.paused) {

          iconPath = 'assets/icons/play.png';

        }
        return ButtonControlsVideo(
          onPressed: () {
            if (_.playing) {
              _.pause();
            } else {
              _.play();
            }
          },
          size: 60,
          iconUrl: iconPath,
        );
      }
    )
    );
  }
}


