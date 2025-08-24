import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = 'AIzaSyDyg-xzptd5HCE9bM5vC2Ju9akMXn6xQgc';
  static const String _apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-05-20:generateContent?key=$_apiKey';

  Future<String?> getResponse(String prompt) async {
    final chatHistory = [
      {
        'role': 'user',
        'parts': [
          {'text': prompt},
        ],
      },
    ];
    final payload = {'contents': chatHistory};

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['candidates'] != null && result['candidates'].isNotEmpty) {
          final content = result['candidates'][0]['content'];
          if (content != null &&
              content['parts'] != null &&
              content['parts'].isNotEmpty) {
            return content['parts'][0]['text'];
          }
        }
      } else {
        debugPrint('❌ Gemini API Error: ${response.body}');
      }
    } catch (e) {
      debugPrint('❌ Gemini request failed: $e');
    }
    return null;
  }
}
