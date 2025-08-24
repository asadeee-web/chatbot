import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageServices {
  List<Map<String, String>> messages = [];
  Future<void> saveMessagesToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(messages);
    await prefs.setString('chat_history', encoded);
  }

  Future<void> loadMessagesFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('chat_history');
    if (data != null) {
      messages = List<Map<String, String>>.from(jsonDecode(data));
    }
  }
}
