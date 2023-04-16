import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(MySocketApp());
}

class MySocketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('WebSocket Example'),
        ),
        body: SocketScreen(),
      ),
    );
  }
}

class SocketScreen extends StatefulWidget {
  @override
  _SocketScreenState createState() => _SocketScreenState();
}

class _SocketScreenState extends State<SocketScreen> {
  TextEditingController _addressController =
  TextEditingController(text: '192.168.42.100');
  TextEditingController _portController = TextEditingController(text: '55001');
  TextEditingController _messageController = TextEditingController(text: 'msg');
  WebSocketChannel? _channel;

  void _connect() {
    if (_channel != null) {
      _channel!.sink.close();
    }
    _channel = IOWebSocketChannel.connect(
        'ws://${_addressController.text}:${_portController.text}');
  }

  void _sendMessage() {
    if (_channel != null) {
      _channel!.sink.add(_messageController.text);
    }
  }

  @override
  void dispose() {
    _channel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _addressController,
            decoration: InputDecoration(
              labelText: 'Address',
            ),
            keyboardType: TextInputType.url,
          ),
          TextField(
            controller: _portController,
            decoration: InputDecoration(
              labelText: 'Port',
            ),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _messageController,
            decoration: InputDecoration(
              labelText: 'Message',
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: _connect,
                child: Text('Connect'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: _sendMessage,
                child: Text('Send Message'),
              ),
            ],
          ),
          StreamBuilder(
            stream: _channel?.stream,
            builder: (context, snapshot) {
              return Text(snapshot.hasData ? '${snapshot.data}' : '');
            },
          ),
        ],
      ),
    );
  }
}
