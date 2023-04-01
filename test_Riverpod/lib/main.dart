import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider<int>((ref) => 0);

void main(){
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MyApp(),
      )
    )
  );
}

class MyApp extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref){
    // watch()を使いデータを受け取る
    final count = ref.watch(counterProvider);
    return Scaffold(
      body: Column(
        children: [
          Center(
            child:
            Text('count changed $count', style:TextStyle(fontSize:30)),
          ),
        ],
      ),
    );
  }
}

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