import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'common.dart';
import 'view_provider.dart';

class ParentFollow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;
    Mode modeState = ref.watch(modeProvider);
    Color colorOn = const Color(0xFF222222);
    Color colorOff = const Color(0xFFDDDDDD);
    Color _colorParent = modeState == Mode.parent ? colorOn : colorOff;
    Color _colorFollow = modeState == Mode.follow ? colorOn : colorOff;

    void _changeColor(Mode modeClicked) {
      ref.read(modeProvider.notifier).changeMode(modeClicked);
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: screenSize.width * 1.0,
        height: 210,
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
                'FOLLOW MODE',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    _changeColor(Mode.parent);
                  },
                  child: Container(
                    width: screenSize.width * 0.3,
                    height: 150,
                    decoration: BoxDecoration(
                      color: _colorParent,
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(
                          color: _colorParent == colorOn ? colorOff : colorOn,
                          width: 2),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.directions_car,
                            color: Colors.black87,
                            size: 100,
                          ),
                        ),
                        Positioned(
                          top: 5,
                          left: 10,
                          child: Text(
                            'PARENT MODE',
                            style: TextStyle(
                                fontSize: 13,
                                color: _colorParent == colorOn
                                    ? colorOff
                                    : colorOn),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _changeColor(Mode.follow);
                  },
                  child: Container(
                    width: screenSize.width * 0.5,
                    height: 150,
                    decoration: BoxDecoration(
                      color: _colorFollow,
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(
                          color: _colorFollow == colorOn ? colorOff : colorOn,
                          width: 2),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Center(
                              child: Icon(
                                Icons.directions_car_filled_outlined,
                                color: Colors.black87,
                                size: 100,
                              ),
                            ),
                            Center(
                              child: Icon(
                                Icons.directions_car_filled_outlined,
                                color: Colors.black87,
                                size: 100,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 5,
                          left: 10,
                          child: Text(
                            'FOLLOW MODE',
                            style: TextStyle(
                              fontSize: 13,
                              color:
                                  _colorFollow == colorOn ? colorOff : colorOn,
                            ),
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
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 60.0, 0.0),
      ),
    ]);
  }
}
