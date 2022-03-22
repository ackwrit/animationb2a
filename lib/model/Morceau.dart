
class Morceau{
  late String  title;
  String? album;
  late String path;
  String? image;
  late String singer;


  Morceau({required this.title,required this.singer,this.album,this.image,required this.path});
}