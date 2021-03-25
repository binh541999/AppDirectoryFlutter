class MemberUsernameOnly {
  String username;

  MemberUsernameOnly({
    this.username,
  });

  @override

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..["username"] = username
    ;
  }
}



class ListMemberUsernameOnly {
  ListMemberUsernameOnly(this.members);

  List<MemberUsernameOnly> members;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'members': members,
  };
}