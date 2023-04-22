import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        decoration: BoxDecoration(
          color: Color(0xFF222222),
        ),
        padding: EdgeInsets.all(8.0), // テキストの内側の間隔を設定
        alignment: Alignment.centerLeft, // テキストを左寄せに設定
        child: Text(
          'Message Area',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
      Container(
        width: screenSize.width * 1.0, // 例: 幅を100に設定
        height: 150, //
        decoration: BoxDecoration(
          color: Color(0xFF222222),
          border: Border.all(color: Colors.white70, width: 2), // 枠線の色と幅を設定
        ),
        padding: EdgeInsets.all(8.0), // テキストの内側の間隔を設定
        alignment: Alignment.centerLeft, // テキストを左寄せに設定
        child: Text(
          'Select Mobility Mode',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    ]);
  }
}

