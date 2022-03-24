import 'dart:async';

import 'package:animationb2a/model/Morceau.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class detail extends StatefulWidget{
  Morceau music;
  detail({required this.music});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailState();
  }

}

class detailState extends State<detail>{
  //Variable
  double time=0.0;
  statutLecture lecture = statutLecture.stopped;
  double volume = 0.5;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duree = Duration(seconds: 0);
  Duration position = Duration(seconds: 0);
  late StreamSubscription positionStream;
  late StreamSubscription stateStream;





  ///
  ///
  ///
  /// Methode de configuration
  configuration(){

    audioPlayer.setUrl(widget.music.path);
    positionStream = audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duree = event;
      });
    });
    stateStream = audioPlayer.onPlayerStateChanged.listen((event) {
      if(event == statutLecture.playing){
        setState(() async {
          duree = audioPlayer.getDuration() as Duration;
        });

      }
      else if(event == statutLecture.stopped){
        setState(() {
          lecture = statutLecture.stopped;
        });
      }
    },
        onError:(message){
      setState(() {
        lecture = statutLecture.stopped;
        position = Duration(seconds: 0);
        duree = Duration(seconds: 0);
      });
        }
    );

  }
  ///
  ///
  /// Methode play
  Future play() async {
    if(position>Duration(seconds: 0)){
      await audioPlayer.play(widget.music.path,volume: volume,position: position,isLocal: true);
    }
    else
      {
        await audioPlayer.play(widget.music.path,volume: volume,isLocal: true);
      }
  }
  ///
  ///
  /// Methode pause
  Future pause() async {
    await audioPlayer.pause();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configuration();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.music.title}"),
      ),
      body: bodyPage(),
    );
  }

  Widget bodyPage(){
    return Container(
      padding: EdgeInsets.all(20),
      child:Column(
        children: [
          //Image du Cover
          Container(
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: (widget.music.image == null)?AssetImage("assets/image/indispo.jpeg"):AssetImage(widget.music.image!),
                    fit: BoxFit.fill
                )
            ),
          ),
          SizedBox(height: 10,),

          //Titre et l'album
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.music.title}",style: TextStyle(fontSize: 30),),
              (widget.music.album == null)?Container():Text(" - ${widget.music.album}",style: TextStyle(fontSize: 30),),
            ],
          ),

          SizedBox(height: 10,),
          // Nom du chanteur
          Text("${widget.music.singer}",style: TextStyle(fontSize: 25),),


          // Icone de lecture
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Teste
              IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.fast_rewind_sharp)
              ),

              (lecture == statutLecture.stopped)?IconButton(
                  onPressed: (){

                    setState(() {
                      lecture = statutLecture.paused;
                      play();
                    });
                  },
                  icon: Icon(Icons.play_arrow,size: 35,)
              ):IconButton(
                  onPressed: (){
                    setState(() {
                      lecture = statutLecture.stopped;
                      pause();
                    });

                  },
                  icon: Icon(Icons.pause,size: 35,)
              ),

              IconButton(
                  onPressed: (){


                  },
                  icon: Icon(Icons.fast_forward_rounded)
              ),

            ],
          ),



          //Timeline
          Slider(
              value: time,
              activeColor: Colors.black,
              inactiveColor: Colors.red,
              onChanged: (value){
                setState(() {
                  time =value;
                });
              }
          )

        ],
      ),
    );
  }

}

enum statutLecture{
  playing,
  stopped,
  paused,
  forward,
  rewind,
}