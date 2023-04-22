import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Follow extends StatefulWidget {
  @override
  _FollowState createState() => _FollowState();
}

class _FollowState extends State<Follow> {
  @override
  Widget build(BuildContext context){

    Size screenSize = MediaQuery.of(context).size;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: screenSize.width * 1.0, // 例: 幅を100に設定
        height: 210, // 例: 高さを100に設定
        decoration: BoxDecoration(
          color: Color(0xFF01067F),
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: Color(0xFF555555), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'FOLLOE MODE',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: screenSize.width * 0.3,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color(0xFFDDDDDD),
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(color: Color(0xFF555555), width: 2),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.directions_railway_filled_outlined,
                            color: Colors.black87,
                            size: 100,
                          ),
                        ),
                        Positioned(
                          top: 5,
                          left: 10,
                          child: Text(
                            'PARENT DEVICE',
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {},
                  child: Container(
                    width: screenSize.width * 0.5,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color(0xFFDDDDDD),
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(color: Color(0xFF555555), width: 2),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.directions_railway_filled_rounded,
                            color: Colors.black87,
                            size: 100,
                          ),
                        ),
                        Positioned(
                          top: 5,
                          left: 10,
                          child: Text(
                            'CHILD DEVICE',
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 60.0, 0.0),
      ),
    ]);
  }
}
