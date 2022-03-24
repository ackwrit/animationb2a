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
    Morceau(title: "Morceau", singer: "Djino", path: "assets/sons/09.AbuSimbel.mp3"),
    Morceau(title: "Big Boss", singer: "Lipton", path: "assets/sons/14.Alibi.mp3",image: "assets/image/Tomb-Raider-definitive-ed-012.jpg"),
    Morceau(title: "All Night", singer: "Table", path: "assets/sons/16.Inheritance.mp3"),
    Morceau(title: "Lemon", singer: "Dowwap", path: "assets/sons/21. IWasn'tThinking.mp3",image: "assets/image/Watch-Dogs-Characters.jpg"),
    Morceau(title: "Ipad", singer: "trousse", path: "assets/sons/23.Perhaps.mp3",image:"assets/image/tumblr_nf5gs7QN3z1tlve1do1_1280.jpg"),

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
