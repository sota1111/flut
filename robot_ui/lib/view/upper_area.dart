import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/common_imports.dart';

class UpperArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 60.0, 0.0, 0.0),
        ),
        Container(
          color: Color(0xFF222222),
          child: Text(
            'welcome piimo',
            style: TextStyles.welcomeMessage,
          ),
        ),
        Container(
          color: Color(0xFF222222),
          padding: EdgeInsets.fromLTRB(8, 10, 0, 0), // 外側の余白を設定
          child: Text(
            'CONTROL SYSTEM',
            style: TextStyles.title,
            textAlign: TextAlign.right, // テキストを右寄せに設定
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
        ),
        Divider(
          color: Colors.white24,
          thickness: 2,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        ),
      ],
    );
  }
}
