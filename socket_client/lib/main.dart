import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert' show utf8;
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _addressController = TextEditingController(text: '192.168.42.100');
  final TextEditingController _portController = TextEditingController(text: '55001');
  final TextEditingController _sendMessage = TextEditingController(text: '%GetUnitInfo\$');
  Socket? socket;
  static String outputLog = "not connect";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _portController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Port'),
            ),
            Form(
              child: TextFormField(
                controller: _sendMessage,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async{
                    _funcConnect();
                  },
                  child: const Text('Connect'),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                ElevatedButton(
                  onPressed: () async{
                    _funcDisconnect();
                  },
                  child: const Text('Disconnect'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(outputLog),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _funcSendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ),
    );
  }

  Future<void> _funcConnect() async {
    // サーバーのIPアドレスとポート番号を設定
    final serverAddress = InternetAddress(_addressController.text);
    final serverPort = int.parse(_portController.text);
    final message = _sendMessage.text;

    try {
      // サーバーに接続する
      socket = await Socket.connect(serverAddress, serverPort, timeout: const Duration(seconds: 5));
      setState(() {
        outputLog = "connected";
      });
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _funcDisconnect() async {
    if (socket != null) {
      await socket!.close();
      setState(() {
        outputLog = "Socket closed";
      });
      debugPrint("Socket closed.");
    } else {
      setState(() {
        outputLog = "No socket to close.";
      });
      debugPrint('No socket to close.');
    }
  }
  void _funcSendMessage() async {
    if (socket == null) {
      debugPrint('Socket is not connected.');
      return;
    }

    // メッセージを送信する
    socket!.write(_sendMessage.text);
    setState(() {
      outputLog = "sent message";
    });

    // サーバーからのデータを非同期で受信する
    socket!.listen((List<int> data) {
      final response = utf8.decode(data);
      debugPrint('Received response: $response');
      setState(() {
        outputLog = "res:$response";
      });
    });
  }

  @override
  void dispose() {
    //_channel?.sink.close();
    _addressController.dispose();
    _portController.dispose();
    _sendMessage.dispose();
    super.dispose();
  }
}
