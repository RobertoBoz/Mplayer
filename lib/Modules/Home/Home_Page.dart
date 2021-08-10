import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplayer/Data/Models/VideoModel.dart';
import 'package:mplayer/Modules/Home/VideoPlayer/MediaPlayerCotroller.dart';

import '/Modules/Home/Home_Controller.dart';
import 'VideoPlayer/m_Player.dart';


class HomePage extends StatelessWidget {

  
  
  @override
  Widget build(BuildContext context) {
    
    var portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    RxBool isPortrait = portrait.obs;
    
    
    return GetBuilder<HomeController>(
      builder: (_) =>  Scaffold(
        body: Obx((){
          
            return  SafeArea(
              top: isPortrait.value,
              bottom: isPortrait.value,
              right: isPortrait.value,
              left: isPortrait.value,             
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: !isPortrait.value ? Colors.black: Colors.white,
                ),
                child:Column(                              
                  children: [
                    Expanded(flex:!isPortrait.value ? 1 : 0 ,child: MPlayer(controller: _.mplayerController,)),
                      (isPortrait.value ) ?  
                      Expanded(
                        flex: 1,
                        child: ListView.builder(
                          itemCount: _.videoList.length,
                          itemBuilder:(BuildContext context, index){
                            final Video video = _.videoList[index];
                            return ListTile(
                              title: Text(video.title),
                              onTap: (){
                                 _.loadnewVideo(video.sources[0]);
                                
                              },
                            );
                          }
                        ),
                      ) : Expanded(flex: 0,child: Container())            
                  ],
                )
              )
           );
          }
        ),
      )          
    );
    
  }
}


