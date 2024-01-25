import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminAuthentication {
  final String baseUrl = 'https://fm9-malayalam.onrender.com/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      final String loginUrl = '$baseUrl/admin/admin-login';

      final Map<String, dynamic> requestBody = {
        'email': email,
        'password': password,
      };

      final response = await http.post(
        Uri.parse(loginUrl),
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );
      log(response.body.toString());
      log('Response from server: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        pref.setBool('isLoggedIn', true);

        return {'success': true, 'message': 'Login successful'};
      } else {
        if (response.headers['content-type']?.contains('application/json') !=
            true) {
          return {'success': false, 'error': 'Unexpected response format'};
        }
        try {
          final Map<String, dynamic> errorResponse = json.decode(response.body);
          return {'success': false, 'error': errorResponse['message']};
        } catch (e) {
          return {
            'success': false,
            'error': 'Failed to decode server response'
          };
        }
      }
    } catch (error) {
      return {'success': false, 'error': 'Error during login: $error'};
    }
  }
}
