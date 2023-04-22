import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/common_imports.dart';

class MessageArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        decoration: BoxDecoration(
          color: boxDecorationStyles.colorBackGround,
        ),
        padding: const EdgeInsets.fromLTRB(5.0, 15.0, 0.0, 0.0),
        alignment: Alignment.centerLeft, // テキストを左寄せに設定
        child: Text(
          'MESSAGE AREA',
          style: TextStyles.messageTitle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
        width: screenSize.width * 1.0,
        // 例: 幅を100に設定
        height: 150,
        //
        decoration: BoxDecoration(
          color: boxDecorationStyles.colorBackGround,
          border: Border.all(color: Colors.white24, width: 1), // 枠線の色と幅を設定
        ),
        alignment: Alignment.topLeft,
        // テキストを左寄せに設定
        child: Text(
          'Select Mobility Mode',
          style: TextStyles.message,
        ),
      ),
    ]);
  }
}
