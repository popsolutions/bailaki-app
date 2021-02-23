class MusicSkill{
  int id;
  String name;

  MusicSkill.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
  }
}