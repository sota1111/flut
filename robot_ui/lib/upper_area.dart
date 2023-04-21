import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UpperArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 60.0, 60.0, 0.0),
        ),
        Container(
          color: Color(0xFF222222),
          child: Text(
            'Welcome PiiMo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 60.0, 0.0),
        ),
        Container(
          color: Color(0xFF222222),
          padding: EdgeInsets.fromLTRB(8, 16, 8, 16), // 外側の余白を設定
          child: Text(
            'Operation Board',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
            textAlign: TextAlign.right, // テキストを右寄せに設定
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 3,
        ),
      ],
    );
  }
}