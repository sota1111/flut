import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Color(0xFF222222),
        appBar: null,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(60.0, 60.0, 60.0, 0.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.white,
                child: Text(
                  'Upper Message Area',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                children: List.generate(4, (index) {
                  return Card(
                    color: Color(0xFF000099),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.directions_car,
                            size: 64.0,
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: CupertinoSwitch(
                                value: false,
                                onChanged: (bool value) {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: Text(
                'Lower Message Area',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Color(0xFF222222),
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
