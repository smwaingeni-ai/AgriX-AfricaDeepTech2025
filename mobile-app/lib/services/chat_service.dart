import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_message.dart';

class ChatService {
  static const String _chatKey = 'chat_messages';

  List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  // Load chat messages from local storage
  Future<void> loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_chatKey);
    if (jsonString != null) {
      final List<dynamic> decoded = jsonDecode(jsonString);
      _messages = decoded.map((msg) => ChatMessage.fromJson(msg)).toList();
    }
  }

  // Save chat messages to local storage
  Future<void> saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(_messages.map((msg) => msg.toJson()).toList());
    await prefs.setString(_chatKey, jsonString);
  }

  // Add a new message
  Future<void> addMessage(ChatMessage message) async {
    _messages.add(message);
    await saveMessages();
  }

  // Clear chat history
  Future<void> clearMessages() async {
    _messages.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chatKey);
  }
}
