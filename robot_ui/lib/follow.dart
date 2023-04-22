import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Follow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: screenSize.width * 1.0, // 例: 幅を100に設定
        height: 220, // 例: 高さを100に設定
        decoration: BoxDecoration(
          color: Color(0xFF000099),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFF555599), width: 3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Follow Mode',
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
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
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black54, width: 3),
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
                            '親機',
                            style: TextStyle(fontSize: 16, color: Colors.black),
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
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black54, width: 3),
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
                            '子機',
                            style: TextStyle(fontSize: 16, color: Colors.black),
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
