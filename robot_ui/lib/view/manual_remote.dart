import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/common.dart';
import '../common/text_styles.dart';
import '../common/container_styles.dart';
import '../common/custom_image.dart';
import 'view_provider.dart';


class ManualRemote extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;
    Mode modeState = ref.watch(modeProvider);
    Color colorOn = TextStyles.subtitleColorOn;
    Color colorOff = TextStyles.subtitleColorOff;
    Color _colorManual = modeState == Mode.manual ? colorOn : colorOff;
    Color _colorRemote = modeState == Mode.remote ? colorOn : colorOff;

    void _changeColor(Mode modeClicked) {
      ref.read(modeProvider.notifier).changeMode(modeClicked);
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: screenSize.width * boxDecorationStyles.ratioSoloBox,
        height: boxDecorationStyles.heightSoloBox,
        decoration: boxDecorationStyles.boxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'SOLO MODE',
                style: TextStyles.modeTitle,
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
                    width: screenSize.width * boxDecorationStyles.ratioManualBox,
                    height: boxDecorationStyles.heightManualBox,
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
                          child: CustomImage(imagePath: _colorManual == colorOff ? 'assets/A.png' : 'assets/B.png'),
                        ),
                        Positioned(
                          top: 5,
                          left: 10,
                          child: Text(
                            'MANUAL MODE',
                            style: TextStyle(
                                fontSize: TextStyles.subtitleFontSize,
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
                    width: screenSize.width * boxDecorationStyles.ratioRemoteBox,
                    height: boxDecorationStyles.heightRemoteBox,
                    decoration: BoxDecoration(
                      color: _colorRemote,
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(
                          color: _colorRemote == colorOn ? colorOff : colorOn,
                          width: 2),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: CustomImage(imagePath: _colorRemote == colorOff ? 'assets/A.png' : 'assets/B.png'),
                        ),

                        Positioned(
                          top: 5,
                          left: 10,
                          child: Text(
                            'REMOTE MODE',
                            style: TextStyle(
                              fontSize: TextStyles.subtitleFontSize,
                              color:
                                  _colorRemote == colorOn ? colorOff : colorOn,
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
