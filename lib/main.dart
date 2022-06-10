import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:learn_flutter/DialogDemo/index.dart';
import 'package:learn_flutter/EventDemo/index.dart';
import 'package:learn_flutter/ProviderDemo/index.dart';
import 'package:learn_flutter/WaterMarkDemo/index.dart';
import 'package:learn_flutter/demoOne/index.dart';
import 'package:learn_flutter/demoTwo/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_flutter/modelDemo/index.dart';
import 'package:learn_flutter/pageViewDemo/index.dart';
import 'package:learn_flutter/pointDemo/index.dart';
import 'package:learn_flutter/sliverDemo/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:learn_flutter/themeDemo/index.dart';

import 'demoFive/index.dart';
import 'demoFour/index.dart';
import 'demoThree/index.dart';
import 'generated/l10n.dart';

void main() {
  // debugPaintSizeEnabled = true; //可视化组件可视边框
  // debugPaintLayerBordersEnabled = true; //调试中组件可视化边界
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
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routes: {
            "one_demo": (context) => FirstDemo(),
            "two_demo": (context) => TwoDemo(),
            "three_demo": (context) => ThreeDemo(),
            "four_demo": (context) => FourDemo(),
            "five_demo": (context) => FiveDemo(),
            "sliver_demo": (context) => SliverDemo(),
            "pointer_demo": (context) => PointerDemo(),
            "provide_demo": (context) => ProviderDemo(),
            "dialog_demo": (context) => DialogDemo(),
            "model_demo": (context) => ModelTestDemo(),
            "water_mark_demo": (context) => WaterMarkDemo(),
            "event_demo": (context) => EventDemo(),
            "theme_demo": (context) => ThemeDemo(),
            "page_view_demo": (context) => PageViewDemo(),
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
            Text(S.of(context).title('ddd')),
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
            Wrap(
              spacing: 10.w,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "one_demo");
                    },
                    child: Text("Canvas Demo")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "two_demo");
                    },
                    child: Text("CircularProgress Demo")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "three_demo");
                    },
                    child: Text("Input Demo")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "four_demo");
                    },
                    child: Text("Linear Demo")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "five_demo");
                    },
                    child: Text("router animation demo")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "sliver_demo");
                    },
                    child: Text("Demo Sliver")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "pointer_demo");
                    },
                    child: Text("Demo Pointer")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "provider_demo");
                    },
                    child: Text("Demo Provider")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "dialog_demo");
                    },
                    child: Text("Demo Dialog")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "model_demo");
                    },
                    child: Text("Demo model")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "water_mark_demo");
                    },
                    child: Text("WaterMark model")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "event_demo");
                    },
                    child: Text("event demo")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "theme_demo");
                    },
                    child: Text("Theme model")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "page_view_demo");
                    },
                    child: Text("pageView demo")),
              ],
            ),
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
