import 'dart:convert';
import 'package:http/http.dart' as http;
final String renderUrl = "https://student-discussion-forum.onrender.com/";

class AuthService {
  final String _signUpUrl = "sdf/user/signUpUrl";
  final String _signInUrl = "sdf/user/login";

  static String? finalUserId;
  static String? finalUserName;

  Future<http.Response> signUp(String username, String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$renderUrl$_signUpUrl"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'phone': phone,
          'password': password,
        }),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<http.Response> signIn(String phoneNumber, String password) async {
    final url = Uri.parse("$renderUrl$_signInUrl?phoneNumber=$phoneNumber&password=$password");

    try {
      print("Attempting to sign in with phone: $phoneNumber and password: $password");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        finalUserId = responseData['data']['userId'];
        finalUserName = responseData['data']['userName'];
        print("Login successful with, userId: $finalUserId, userName: ${finalUserName}");
        return response;
      } else {
        throw Exception('Failed to sign in: ${response.body}');
      }
    } catch (e) {
      print("Exception occurred: $e");
      throw Exception('Failed to sign in: $e');
    }
  }
}
