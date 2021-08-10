import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplayer/Utils/Helper.dart';

import '../MediaPlayerCotroller.dart';
import 'ButtonControlsVideo.dart';
import 'MSlider.dart';

class MPControls extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    
    return  GetBuilder<MediaPlayerController>(
      builder: (_) => Positioned.fill(
        child:  Obx(
          ()=> GestureDetector(
            onTap: () => _.onShowControls(),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: double.infinity,
              color: _.showControls ? Colors.black54 : Colors.transparent,  
              
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  AbsorbPointer(
                    absorbing: !_.showControls,
                    child: AnimatedOpacity(
                      opacity: _.showControls ? 1 : 0, 
                      duration: Duration(milliseconds: 300),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ButtonControlsVideo(iconUrl: 'assets/icons/rewind.png', size: 50,onPressed: _.rewind,),
                          SizedBox(width: 20,),
                          ButtonMedialPlayer(),                  
                          SizedBox(width: 20,),
                          ButtonControlsVideo(iconUrl: 'assets/icons/fast-forward.png', size: 50,onPressed: _.fastForward),
                        ],
                      ),
                    ),
                  )
                  ,
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    bottom: _.showControls ?  0: -70,
                    left: 0,
                    right: 0,                
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Obx(() => Text(Helper().parceDuration(_.position),style: TextStyle(color: Colors.white),)),
                          SizedBox(width: 10,),
                          MSlider(),
                          SizedBox(width: 10,),
                          MuteButton(),
                          SizedBox(width: 10,),
                          FullScreenButton(),
                          SizedBox(width: 10,),
                          Obx(() => Text(Helper().parceDuration(_.duration),style: TextStyle(color: Colors.white),)),
                        ],
                      ),
                    ),
                  )
              
                ],
              
              ),          
            ),
          ),
        )
      )
      
    );
  }
}