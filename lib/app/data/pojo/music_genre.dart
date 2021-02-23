class MusicGenre{
  int id;
  String name;

  MusicGenre.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
  }
}