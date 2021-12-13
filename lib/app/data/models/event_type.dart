class Even_typeModel{
  int id;
  String name;
  bool selected = true;

  Even_typeModel({this.id, this.name, this.selected = true});

  factory Even_typeModel.fromMap(Map<String, dynamic> map) {
    return Even_typeModel(
        id: map['id'],
        name: map['name']
    );
  }

}