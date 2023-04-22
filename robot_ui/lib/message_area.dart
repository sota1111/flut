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
        padding: const EdgeInsets.fromLTRB(5.0, 15.0, 0.0, 0.0),
        alignment: Alignment.centerLeft, // テキストを左寄せに設定
        child: Text(
          'MESSAGE AREA',
          style: TextStyle(
            color: Colors.white,
            fontSize:20,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
        width: screenSize.width * 1.0, // 例: 幅を100に設定
        height: 150, //
        decoration: BoxDecoration(
          color: Color(0xFF262626),
          border: Border.all(color: Color(0xFF555555), width: 1), // 枠線の色と幅を設定
        ),
        alignment: Alignment.topLeft, // テキストを左寄せに設定
        child: Text(
          'Select Mobility Mode',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 15,
          ),
        ),
      ),
    ]);
  }
}

