import 'package:app/src/models/poll.dart';
import 'package:app/src/models/vote.dart';

class User {
  String iD;
  String name;
  String email;
  bool isAdmin;
  List<Poll> polls;
  List<Vote> votes;

  User({this.iD, this.name, this.email, this.isAdmin, this.polls, this.votes});

  User.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    email = json['Email'];
    isAdmin = json['IsAdmin'];
    polls = (json['Polls'] as List).map((p) => Poll.fromJson(p)).toList();
    votes = (json['Votes'] as List).map((p) => Vote.fromJson(p)).toList();
  }
}
