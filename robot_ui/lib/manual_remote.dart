import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'common.dart';

final modeProvider = StateProvider<Mode>((ref) => Mode.neutral);

class ManualRemote extends StatefulWidget {
  @override
  _ManualRemoteState createState() => _ManualRemoteState();
}

class _ManualRemoteState extends State<ManualRemote> {
  Color colorOn = const Color(0xFF222222);
  Color colorOff = const Color(0xFFDDDDDD);
  late Color _colorManual;
  late Color _colorRemote;
  Mode _modeSelected = Mode.neutral;

  _ManualRemoteState() {
    super.initState();
    _colorManual = colorOff;
    _colorRemote = colorOff;
  }

  void _changeColor(Mode modeClicked) {
    setState(() {
      //Mode _modeSellected = watch(modeProvider).state;
      if (_modeSelected == modeClicked) {
        _modeSelected = Mode.neutral;
      } else {
        _modeSelected = modeClicked;
      }

      if (_modeSelected == Mode.neutral) {
        _colorManual = colorOff;
        _colorRemote = colorOff;
      } else if (_modeSelected == Mode.manual) {
        _colorManual = colorOn;
        _colorRemote = colorOff;
      } else if (_modeSelected == Mode.remote) {
        _colorManual = colorOff;
        _colorRemote = colorOn;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                'SOLO MODE',
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    _changeColor(Mode.manual);
                  },
                  child: Container(
                    width: screenSize.width * 0.4,
                    height: 150,
                    decoration: BoxDecoration(
                      color: _colorManual,
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(
                          color: _colorManual == colorOn ? colorOff : colorOn,
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
                            'MANUAL MODE',
                            style: TextStyle(
                                fontSize: 12,
                                color: _colorManual == colorOn
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
                    _changeColor(Mode.remote);
                  },
                  child: Container(
                    width: screenSize.width * 0.4,
                    height: 150,
                    decoration: BoxDecoration(
                      color: _colorRemote,
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(color: _colorRemote == colorOn ? colorOff : colorOn, width: 2),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.directions_car_filled_outlined,
                            color: Colors.black87,
                            size: 100,
                          ),
                        ),
                        Positioned(
                          top: 5,
                          left: 10,
                          child: Text(
                            'REMOTE MODE',
                            style: TextStyle(fontSize: 12, color: _colorRemote == colorOn ? colorOff : colorOn,),
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

