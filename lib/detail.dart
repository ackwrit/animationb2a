import 'package:animationb2a/model/Morceau.dart';
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
  double time=0.0;
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
              (widget.music.album == null)?Container():Text("${widget.music.album}",style: TextStyle(fontSize: 30),),
            ],
          ),

          SizedBox(height: 10,),
          // Nom du chanteur
          Text("${widget.music.singer}",style: TextStyle(fontSize: 25),),


          // Icone de lecture
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.fast_rewind_sharp)
              ),

              IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.play_arrow,size: 35,)
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