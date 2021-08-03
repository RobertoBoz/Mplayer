import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplayer/Data/Models/VideoModel.dart';

import '/Modules/Home/Home_Controller.dart';
import 'Widget/m_Player.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) =>  Scaffold(
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                MPlayer(),
                Expanded(
                  child: ListView.builder(
                    itemCount: _.videoList.length,
                    itemBuilder:(BuildContext context, index){
                      final Video video = _.videoList[index];
                      return ListTile(
                        title: Text(video.title),
                      );
                    }
                  )
                )              
              ],
            ),
          ),
        ),    
      ),
    );
  }
}

