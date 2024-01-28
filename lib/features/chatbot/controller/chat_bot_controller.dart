import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final chatBotControllerProvider =
    StateNotifierProvider<ChatBotController, List<String>>((ref) {
  return ChatBotController(ref: ref);
});

final chatMessagesProvider = Provider<List<String>>((ref) {
  return ref.watch(chatBotControllerProvider);
});

class ChatBotController extends StateNotifier<List<String>> {
  final Ref _ref;

  ChatBotController({
    required Ref ref,
  })  : _ref = ref,
        super([]);

  Future<void> sendMessageAndFetchAnswer(String question) async {
    // Add user's question to chat
    _ref.read(chatBotControllerProvider.notifier).state = [
      ...state,
      'User: $question'
    ];

    // Fetch answer from the chat bot API
    try {
      final answer = await fetchAnswer(question);
      // Add bot's answer to chat
      _ref.read(chatBotControllerProvider.notifier).state = [
        ...state,
        'Bot: $answer'
      ];
    } catch (error) {
      print('Error: $error');
      // Add an error message to chat
      _ref.read(chatBotControllerProvider.notifier).state = [
        ...state,
        'Bot: Error fetching the answer.'
      ];
    }
  }

Future<String> fetchAnswer(String question) async {
  final dio = Dio();
  final apiUrl = 'https://flask-chat-bot.onrender.com/$question';

  try {
    final response = await dio.get(apiUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final String answer = data['ans'];

      return answer;
    } else {
      throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
    return 'Error occurred while fetching the answer.';
  }
}
}
