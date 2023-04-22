import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/container_styles.dart';
import 'view/upper_area.dart';
import 'view/manual_remote.dart';
import 'view/parent_follow.dart';
import 'view/message_area.dart';
import 'view/bottom_navi.dart';

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
        backgroundColor: boxDecorationStyles.colorBackGround,
        appBar: null,
        body: Column(
          children: [
            UpperArea(),
            ManualRemote(),
            ParentFollow(),
            MessageArea(),
          ],
        ),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    ));
  }
}
