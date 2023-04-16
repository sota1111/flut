import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
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
  TextEditingController _addressController = TextEditingController(text: '127.0.0.1');
  TextEditingController _portController = TextEditingController(text: '8080');
  TextEditingController _controller = TextEditingController();
  WebSocketChannel? _channel;
  static var output_log='output_log';
  //final __channel = WebSocketChannel.connect(
    //Uri.parse('ws://localhost:8080'),
  //);

  @override
  void initState() {
    super.initState();
    _connect(); // Initialize _channel with default address and port
    _disconnect(); // Initialize _channel with default address and port
  }

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
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _portController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Port'),
            ),
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel?.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async{
                    _connect();
                  },
                  child: Text('Connect'),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                ElevatedButton(
                  onPressed: () async{
                    _disconnect();
                  },
                  child: Text('Disconnect'),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(output_log),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ),
    );
  }

  void _connect() async {
    String address = _addressController.text;
    int port = int.parse(_portController.text);

    if (_channel != null) {
      _channel!.sink.close();
    }
    //_channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));
    _channel = WebSocketChannel.connect(Uri.parse('ws://$address:$port'));
    //_channel = IOWebSocketChannel.connect('ws://$address:$port');
  }
  void _disconnect()  {
    setState(() {
      output_log = "disconnect";
      });
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
    }
  }
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel?.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel?.sink.close();
    _addressController.dispose();
    _portController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
