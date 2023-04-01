import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
  // Adding ProviderScope enables Riverpod for the entire project
  const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  final title = 'Graphic Sample';
  final message = 'サンプル・メッセージ';

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(
        title: this.title,
        message: this.message
      )
    );
  }
}

/// Providers are declared globally and specify how to create a state
final counterProvider = StateProvider((ref) => 0);

class MyHomePage extends StatefulWidget{
  final String title;
  final String message;
  const MyHomePage({
    Key? key,
    required this.title,
    required this.message
  }): super(key: key);

  @override
  _TetrisState createState() => _TetrisState();

}

class _TetrisState extends State<MyHomePage> {
  static double _minoX = 0;
  static double _minoY = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,255,255,255),
      //appBar: AppBar(
        //title: Text('MyTetris', style: TextStyle(fontSize: 30.0),),
      //),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          CustomPaint(
            // draw Line
            painter: DrawLine(),
          ),
          CustomPaint(
            // draw Line
            painter: DrawRectangle(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: (){
                    _minoX -= 1;
                    print('${_minoX}');
                    },
                  child: Text("Left"),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      _minoY += 1;
                      print('${_minoY}');
                      },
                    child: Text("TurnAround"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      _minoY -= 1;
                      print('${_minoY}');
                    },
                    child: Text("Down"),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: (){
                  _minoX += 1;
                  print('${_minoX}');
                  },
                child: Text("Right"),
              ),
            ],
          )
        ]
      ),
    );
  }
}

class DrawRectangle extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    Paint p = Paint();
    p.style = PaintingStyle.fill;
    p.color = Color.fromARGB(150,0,200,255);
    Rect r = Rect.fromLTWH(-150.0+_TetrisState._minoX*30.0, -282-_TetrisState._minoY*30.0, 30, 30);
    canvas.drawRect(r, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class DrawLine extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    Paint p = Paint();
    p.style = PaintingStyle.stroke;
    p.strokeWidth = 2.0;
    p.color = Color.fromARGB(100, 0, 0, 0);
    var basePosX = -150.0;
    var basePosY = 50.0;
    for (var i = 0; i <= 10; i++){
      Rect r = Rect.fromLTRB(//左、上、右、下
          basePosX+30*i, basePosY+0.0, basePosX+30*i, basePosY+600);
      canvas.drawLine(r.topLeft, r.bottomRight, p);
    }
    for (var i = 0; i <= 20; i++){
      Rect r = Rect.fromLTRB(//左、上、右、下
          basePosX, basePosY+30*i, basePosX+300.0, basePosY+30*i);
      canvas.drawLine(r.topLeft, r.bottomRight, p);
    }


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}




class MyWidget extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref){

    //final Provider<String> provider = Provider((ref){
    //  return 'Hello';
    //});

    //final String data = ref.watch(provider);
    final data = 'test';
    return Scaffold(
      body: Center(
        child: Text(data),
      ),
    );
  }
}
class testClass {
    //Providerを使うことを宣言
    final provider = Provider((ref){
      return 'Hello';
    });
    //どの使い方にするかを選択
    final container = ProviderContainer();
    late final hello = container.read(provider);
}
