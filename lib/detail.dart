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

  rewind(){
    if(position <= Duration(seconds:5)){
      setState(() {
        audioPlayer.stop();
        audioPlayer.seek(Duration(seconds: 0));
        position = new Duration(seconds: 0);
        audioPlayer.play(widget.music.path,position: position,volume: volume);
      });

    }
    else
      {
        setState(() {
          audioPlayer.stop();
          audioPlayer.seek(Duration(seconds: position.inSeconds - 5));
          position = new Duration(seconds: position.inSeconds - 5);
          audioPlayer.play(widget.music.path,position: position,volume: volume);

        });



      }
  }

  forward(){
    if(position.inSeconds + 10< duree.inSeconds){
      setState(() {
        position = new Duration(seconds: position.inSeconds+10);
        audioPlayer.pause();
        audioPlayer.play(widget.music.path,position: position,volume: volume);
      });
    }
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
          Hero(
              tag: widget.music.title,
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: (widget.music.image == null)?AssetImage("assets/image/indispo.jpeg"):AssetImage(widget.music.image!),
                        fit: BoxFit.fill
                    )
                ),
              )),

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
                    rewind();

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
                    forward();


                  },
                  icon: Icon(Icons.fast_forward_rounded)
              ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(position.toString().substring(2,7)),
              Text(duree.toString().substring(2,7))

            ],
          ),



          //Timeline
          Slider(
              value: position.inSeconds.toDouble(),
              min: 0.0,
              max: (duree == null)?0.0:duree.inSeconds.toDouble(),
              activeColor: Colors.black,
              inactiveColor: Colors.red,
              onChanged: (value){
                setState(() {
                  Duration timepass = Duration(seconds: value.toInt());
                  position = timepass;
                  audioPlayer.play(widget.music.path,position: position,volume: volume);
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