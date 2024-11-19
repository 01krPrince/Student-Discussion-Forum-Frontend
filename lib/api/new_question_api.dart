import 'dart:convert';
import 'package:http/http.dart' as http;

import '../validation/validation_api.dart';

class NewQuestionApi {
  Future<bool> postNewQuestion(String title, String description, String tag, String options) async {
    final url = Uri.parse('${renderUrl}sdf/question/newQuestion');

    final headers = {
      'Content-Type': 'application/json',
    };

    final String? userId = AuthService.finalUserId;

    if (userId == null) {
      print('Error: userId is null');
      return false;
    }

    final body = jsonEncode({
      "userId": userId,
      'title': title,
      'description': description,
      'tag': tag,
      'options': options.split(',').map((option) => option.trim()).toList(),
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Question posted successfully.');
        return true;
      } else {
        print('Failed to post question.');
        return false;
      }
    } catch (e) {
      print('Error posting question: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchMyQuestions() async {

    final String? userId = AuthService.finalUserId;
    final url = Uri.parse('${renderUrl}sdf/question/viewMyQuestions?userId=$userId');

    try {
      final response = await http.get(url);

      print('Fetch Questions Status Code: ${response.statusCode}');
      print('Fetch Questions Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        print('Questions fetched successfully.');
        return List<Map<String, dynamic>>.from(data);
      } else {
        print('Failed to fetch questions.');
        return [];
      }
    } catch (e) {
      print('Error fetching questions: $e');
      return [];
    }
  }
}
