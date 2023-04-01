import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BlockMovement {
  uP,
  DOWN,
  LEFT,
  RIGHT,
  ROTATE_CLOCKWISE,
  ROTATE_COUNTER_CLOCKWISE
}

class Block {
  late int x;
  late int y;
  late Color color;
  late List<List<int>> _IBlock;
  Block(this.x, this.y, this.color,_IBlock){
    _IBlock = [[0,1,0,0],[0,1,0,0],[0,1,0,0],[0,1,0,0]];
  }
//動かせるようになったら、Blockを継承で作る。
}