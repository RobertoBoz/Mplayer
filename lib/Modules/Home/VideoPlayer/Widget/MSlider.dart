import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplayer/Utils/Helper.dart';
import '../MediaPlayerCotroller.dart';

class MSlider extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MediaPlayerController>(
      builder: (_) => Expanded(
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [                        
            Container(
                child: LayoutBuilder(builder: (BuildContext context,BoxConstraints constraint){
                    return Obx((){
                      double percent = 0;
                      if(_.bufferedLoaded != null &&  _.bufferedLoaded.inMilliseconds > 0 ){
                        percent = _.bufferedLoaded.inSeconds / _.duration.inSeconds;

                      }
                      
                      return  AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: constraint.maxWidth * percent,
                        color: Colors.white30,
                        height: 5,
                      );

                    }
                    
                    );
                }
              ),
            ),
            
            Obx((){
              return 
              (_.sliderPosition.inSeconds >  _.duration.inSeconds || _.duration.inSeconds <= 0 ) ? Container():
              SliderTheme(
                data: SliderThemeData(
                  trackShape: MSliderTrackShape()
                ),
                child: Slider(
                  value: _.sliderPosition.inSeconds.toDouble(),
                  min: 0, 
                  onChangeEnd: (v){
                    _.onChangeEnd();
                     _.seekTo(
                      Duration(
                        seconds: v.floor(),
                      )
                      );
                  },
                  onChangeStart: (v){
                    _.onChangeStart();
                  },            
                  divisions: _.duration.inSeconds,
                  label: Helper().parceDuration(_.sliderPosition),
                  max: _.duration.inSeconds.toDouble(),
                  onChanged: _.onChange
                ),
              );
            }),
          ],
        )
      )
    );
  }
}


class MSliderTrackShape extends RoundedRectSliderTrackShape{

  @override
  Rect getPreferredRect({required RenderBox parentBox, Offset offset = Offset.zero, required SliderThemeData sliderTheme, bool isEnabled = false, bool isDiscrete = false}) {
    
    return Rect.fromLTWH(
      offset.dx, 
      offset.dy + parentBox.size.height / 2 - 2 , 
      parentBox.size.width, 
      4
    );
  }
}