import 'dart:convert';

import 'package:app/src/models/poll.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Future<String> get token async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> postUser() async {
    await http.post('http://localhost:8080/users',
        headers: {"Authorization": "Bearer ${await token}"});
  }

  Future<List<Poll>> getPublicPolls() async {
    var res = await http.get('http://localhost:8080/public/polls');
    return (json.decode(res.body) as List)
        .map((p) => Poll.fromJson(p))
        .toList();
  }
}
