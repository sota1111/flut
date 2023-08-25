import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'utilities.dart';
import 'dart:async';
import 'apiService.dart';

class ChatRoomTetris extends StatefulWidget {
  const ChatRoomTetris({Key? key}) : super(key: key);

  @override
  ChatRoomState createState() => ChatRoomState();
}

class ChatRoomState extends State<ChatRoomTetris> {
  final List<types.Message> _messages = [];
  late types.User _user;
  final types.User _tetris = const types.User(
    id: 'tetris',
    firstName: "Smino",
    lastName: "",
    imageUrl: ImageUrls.tetrisSmino,
  );
  ApiService? _apiService;

  @override
  void initState() {
    super.initState();
    _addMessage(types.TextMessage(
      author: _tetris,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: "ご用件はなんですか？",
    ));

    _apiService = ApiService();
    initializeAsyncMethods();
  }
  Future<void> initializeAsyncMethods() async {
    String? identityId = _apiService?.getIdentityId;
    _user = types.User(id: identityId ?? 'xxxxx-xxxxx-xxxxx');
    //await _apiService?.signOut();
    Map<String, dynamic>? apiResponseData = await _apiService?.performAuthorizedGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('tetrisチャット')),
      body: Chat(
        user: _user,
        messages: _messages,
        onSendPressed: _handleSendPressed,
        showUserAvatars: true,
        showUserNames: true,
      ),
    );
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);

    Map<String, dynamic>? apiResponseData = await _apiService?.performAuthorizedPost(message.text);

    final responseText = apiResponseData?['message'] ?? 'Failed';
    debugPrint(responseText);

    //final sanitizedResponseText = responseText.replaceFirst('\n', '');
    //final finalResponseText = sanitizedResponseText + "\n\n多分、ヨシ！";

    final responseMessage = types.TextMessage(
      author: _tetris,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: responseText,
    );
    _addMessage(responseMessage);
  }
}
