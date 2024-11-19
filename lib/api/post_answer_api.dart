import 'package:http/http.dart' as http;

import '../validation/validation_api.dart';

class PostAnswerApi {
  final String baseUrl = "${renderUrl}sdf/answer/postAnswer";

  Future<bool> postAnswer(String questionId, String answer) async {
    final String? userId = AuthService.finalUserId;
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: {
          'userId': userId,
          'questionId': questionId,
          'answer': answer,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to post answer. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error posting answer: $e');
      return false;
    }
  }
}
