import 'package:flutter/material.dart';
import 'package:learn_flutter/demoOne/index.dart';
import 'package:learn_flutter/demoTwo/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'demoThree/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 690),
        builder: () => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            "one_demo": (context) => FirstDemo(),
            "two_demo": (context) => TwoDemo(),
            "three_demo": (context) => ThreeDemo()
          },
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        )
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _turns = .0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TurnBox(
              turns: _turns,
              speed: 500,
              child: const Icon(
                Icons.refresh,
                size: 150,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _turns += 0.2;
                  });
                },
                child: Text('顺时针旋转1/5圈')),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _turns -= 0.2;
                  });
                },
                child: Text('逆时针旋转1/5圈')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "one_demo");
                },
                child: Text("to demo one")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "two_demo");
                },
                child: Text("to demo two")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "three_demo");
                },
                child: Text("to demo three"))
          ],
        ),
      ),
    );
  }
}


class TurnBox extends StatefulWidget {
  final double turns;
  final int speed;
  final Widget child;

  const TurnBox({
    Key? key,
    this.turns = .0,
    this.speed = 200,
    required this.child,
  }) : super(key: key);

  @override
  State<TurnBox> createState() => _TurnBoxState();
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: -double.infinity,
      upperBound: double.infinity
    );
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }
}
