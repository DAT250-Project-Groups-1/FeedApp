class User {
  String iD;
  String name;
  String email;
  bool isAdmin;
  dynamic polls;
  dynamic votes;

  User({this.iD, this.name, this.email, this.isAdmin, this.polls, this.votes});

  User.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    email = json['Email'];
    isAdmin = json['IsAdmin'];
    polls = json['Polls'];
    votes = json['Votes'];
  }
}
