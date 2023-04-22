import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'upper_area.dart';
import 'manual_remote.dart';
import 'follow.dart';
import 'message_area.dart';
import 'bottom_navi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF222222),
        appBar: null,
        body: Column(
          children: [
            UpperArea(),
            ManualRemote(),
            Follow(),
            MessageArea(),
          ],
        ),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }
}
