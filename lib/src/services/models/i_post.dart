class IPost {
  int id;
  Map<String, dynamic> employee;

  IPost.fromJson(Map<String, dynamic> json) {
    if (json == null) return;

     id = json['employeeId'];
     employee = json;

  }

  static List<IPost> listFromJson(List<dynamic> json) {
    return json == null ? 'null' : json.map((value) => IPost.fromJson(value)).toList();

  }
}
