
class GroupMember {
  int idGroup;
  String userName;

  GroupMember({
    this.idGroup,
    this.userName,
  });

  List<Object> get props => [idGroup, userName];
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>()
      ..["idGroup"] = idGroup
      ..["idMember"] = userName
    ;
  }
  static GroupMember formJson(Map<String, dynamic> json) {
    return GroupMember()
      ..idGroup = json["idGroup"]
      ..userName = json["idMember"];
  }

}

