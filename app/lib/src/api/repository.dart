import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<void> postUser(User user) async {
    final token = await user.getIdToken();
    await http.post('http://localhost:8080/users',
        headers: {"Authorization": "Bearer $token"});
  }
}
