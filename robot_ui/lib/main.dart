import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'upper_area.dart';
import 'manual_remote.dart';
import 'follow.dart';
import 'message_area.dart';
import 'bottom_navi.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ProviderScope(
      child: Scaffold(
        backgroundColor: Color(0xFF262626),
        appBar: null,
        body: Column(
          children: [
            UpperArea(),
            ManualRemote(),
            //Follow(),
            MessageArea(),
          ],
        ),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    ));
  }
}
