import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_message.dart';

class ChatService {
  static const String _chatKey = 'chat_messages';
  List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  /// Loads saved messages from local storage
  Future<void> loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_chatKey);
    if (jsonString != null) {
      final List<dynamic> decoded = jsonDecode(jsonString);
      _messages = decoded.map((msg) => ChatMessage.fromJson(msg)).toList();
    }
  }

  /// Saves current messages to local storage
  Future<void> saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_messages.map((msg) => msg.toJson()).toList());
    await prefs.setString(_chatKey, jsonString);
  }

  /// Adds a new user or bot message
  Future<void> addMessage(ChatMessage message) async {
    _messages.add(message);
    await saveMessages();
  }

  /// Clears all saved messages
  Future<void> clearMessages() async {
    _messages.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_chatKey);
  }

  /// Simulates a bot response (AgriGPT)
  static Future<String> getBotResponse(String userMessage) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate processing time
    return "I'm AgriGPT. I received: \"$userMessage\"";
  }
}
