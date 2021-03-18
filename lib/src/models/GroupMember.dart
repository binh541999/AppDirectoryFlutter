
class GroupMember {
  int idGroup;
  int idMember;

  GroupMember({
    this.idGroup,
    this.idMember,
  });

  @override
  List<Object> get props => [idGroup, idMember];
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>()
      ..["idGroup"] = idGroup
      ..["idMember"] = idMember
    ;
  }
  static GroupMember formJson(Map<String, dynamic> json) {
    return GroupMember()
      ..idGroup = json["idGroup"]
      ..idMember = json["idMember"];
  }

}

