
class Groups {
  int id;
  String name;

  Groups({
    this.id,
    this.name,
  });

  List<Object> get props => [id, name];
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>()
      ..["id"] = id
      ..["name"] = name
    ;
  }
  static Groups formJson(Map<String, dynamic> json) {
    return Groups()
      ..id = json["id"]
      ..name = json["name"];
  }

}

