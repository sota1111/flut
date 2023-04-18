import 'package:flutter/material.dart';
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
  final TextEditingController _controller = TextEditingController(text: '%GetUnitInfo\$');
  WebSocketChannel? _channel;
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
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel?.stream,
              builder: (context, snapshot) {
                //return Text('hoge');
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async{
                    _connect();
                  },
                  child: const Text('Connect'),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                ElevatedButton(
                  onPressed: () async{
                    _disconnect();
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
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ),
    );
  }

  void _connect() async {
    String address = _addressController.text;
    int port = int.parse(_portController.text);
    setState(() {
      if (_channel == null) {
        setState(() {
          _channel = WebSocketChannel.connect(Uri.parse('ws://$address:$port'));
        });
        outputLog = "connected";
      }
    });
  }
  void _disconnect()  {
    setState(() {
      outputLog = "disconnected";
    });
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
    }
  }
  void _sendMessage() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        _channel?.sink.add(_controller.text);
      }
    });
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
