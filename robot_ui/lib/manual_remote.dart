import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ManualRemote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 60.0, 0.0),
      ),
      Container(
        width: 550, // 例: 幅を100に設定
        height: 200, // 例: 高さを100に設定
        decoration: BoxDecoration(
          color: Colors.grey, // 背景色を灰色に設定
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black), // 枠の色を黒に設定
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                width: 190,
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xFF000099),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                  child: Icon(
                    Icons.directions_car,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: 190,
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xFF009900), // 2つ目のInkWellの色を変更
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                  child: Icon(
                    Icons.directions_car,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 60.0, 0.0),
      ),

      Container(
        color: Color(0xFF222222),
        child: Text(
          'Message',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),


    ]);
  }
}