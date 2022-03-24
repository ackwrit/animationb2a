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
    return Text("Ma musique");
  }

}