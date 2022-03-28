import 'package:animationb2a/detail.dart';
import 'package:animationb2a/model/Morceau.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Morceau> allMorceau =[
    Morceau(title: "Morceau", singer: "Djino", path: "https://firebasestorage.googleapis.com/v0/b/firstapplicationb2.appspot.com/o/14.Alibi.mp3?alt=media&token=179da900-4ad3-4f09-806a-2dbf9287b377",album: "B2"),
    Morceau(title: "Big Boss", singer: "Lipton", path: "https://firebasestorage.googleapis.com/v0/b/firstapplicationb2.appspot.com/o/21.%20IWasn'tThinking.mp3?alt=media&token=5c0243c4-24fb-4093-a641-979a192e83ab",image: "assets/image/Tomb-Raider-definitive-ed-012.jpg"),
    Morceau(title: "All Night", singer: "Table", path: "https://firebasestorage.googleapis.com/v0/b/firstapplicationb2.appspot.com/o/16.Inheritance.mp3?alt=media&token=cea90b02-3a56-406c-9bbe-c518b912a739"),
    Morceau(title: "Lemon", singer: "Dowwap", path: "https://firebasestorage.googleapis.com/v0/b/firstapplicationb2.appspot.com/o/14.Alibi.mp3?alt=media&token=179da900-4ad3-4f09-806a-2dbf9287b377",image: "assets/image/Watch-Dogs-Characters.jpg"),
    Morceau(title: "Ipad", singer: "trousse", path: "https://firebasestorage.googleapis.com/v0/b/firstapplicationb2.appspot.com/o/09.AbuSimbel.mp3?alt=media&token=8daedddc-41bf-4e8c-b065-eefc29ba5eb4",image:"assets/image/terrence_ross_by_pjosull-d67njkm.jpg"),

  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: bodyPage(),
        //Derbière versio
      )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget bodyPage(){
    return GridView.builder(
      itemCount: allMorceau.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 20,mainAxisSpacing: 20),
        itemBuilder: (context,index){
          return InkWell(
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: (allMorceau[index].image == null)?AssetImage("assets/image/indispo.jpeg"):AssetImage(allMorceau[index].image!),
                      fit: BoxFit.fill
                  )
              ),
            ),
            onTap: (){
              print("J'ai taper");
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return detail(music: allMorceau[index],);
                  }
              ));
            },
          );

        }
    );
  }
}
