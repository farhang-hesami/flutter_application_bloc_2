class Users {
  int? id;
  String? fullName;

  Users({this.id, this.fullName});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['FullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['FullName'] = this.fullName;
    return data;
  }
}
