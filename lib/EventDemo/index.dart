
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class EventDemo extends StatefulWidget {
  const EventDemo({Key? key}) : super(key: key);

  @override
  State<EventDemo> createState() => _EventDemoState();
}

class _EventDemoState extends State<EventDemo> {

  String _busText = "init test";
  PointerEvent? _event;
  bool _testStatus = false;
  int _counter = 0;
  ValueNotifier<int> _notifier = ValueNotifier<int>(0);  //监听变量
  ComplicatedObjectNotifier _notifier2 = ComplicatedObjectNotifier(ComplicatedObject(number: 0, title: "标题"));
  Widget _content = Center(
    child: Text('这里是内容，，，，，，，'),
  );
  
  void _incrementCounter() {
    _counter++;
    _notifier.value++;
  }

  void _incrementCounter2() {
   _notifier2.setTitle('又是新标题');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bus.on("testbus", (args) {
      print('============');
      print(args);
      this.setState(() {
        _busText = args;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("event Demo"),),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w),

            child: Column(
              children: [
              ElevatedButton(
                      onPressed: () {
                        bus.emit("testbus",'this is test mess');
                      },
                      child: Text("add")
                  ),
                SizedBox(height: 30.w,),
                Text(_busText)
              ],
            ),

            // child: NotificationRoute(),

            // child: _Scale(),

            // child: _DragVertical(),

            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Text("event Demo"),
            //     SizedBox(height: 30.w,),
            //     ValueListenableBuilder(
            //       valueListenable: _notifier,
            //       builder: (BuildContext context, int value, _) {
            //         return Container(
            //           child: Text('you have pushed the button this many times:$value'),
            //         );
            //       },
            //     ),
            //     Text(_counter.toString()),
            //     ElevatedButton(
            //         onPressed: _incrementCounter,
            //         child: Text("add")
            //     ),
            //     Text("================="),
            //     ValueListenableBuilder(
            //         valueListenable: _notifier2,
            //         child: _content,
            //         builder: (BuildContext context, ComplicatedObject value, child) {
            //           return Column(
            //             children: [
            //               Text('title:${value.title};number:${value.number}'),
            //               child as Widget,
            //             ],
            //           );
            //         }
            //     ),
            //     ElevatedButton(
            //         onPressed: _incrementCounter2,
            //         child: Text("add")
            //     ),
            //     SizedBox(height: 30.w,),
            //     Text(_testStatus.toString()),
            //     ElevatedButton(
            //         onPressed: () {
            //           print(_testStatus);
            //           setState(() {
            //             _testStatus = !_testStatus;
            //           });
            //           print(_testStatus);
            //         },
            //         child: Text("testFn")
            //     ),
            //
            //     SizedBox(height: 30.w,),
            //     Listener(
            //       child: Container(
            //         alignment: Alignment.center,
            //         color: Colors.blue,
            //         width: 300.w,
            //         height: 150.w,
            //         child: Text(
            //           "${_event?.localPosition ?? '位置'}",
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ),
            //       onPointerDown: (PointerDownEvent event) {
            //         setState(() {
            //           _event = event;
            //         });
            //       },
            //       onPointerMove: (PointerMoveEvent event) => setState(()=>_event = event),
            //       onPointerUp: (PointerUpEvent event) => setState(()=>_event = event),
            //     ),
            //   ],
            // ),
          ),
        )
    );
  }
}

class ComplicatedObject {
  int number;
  String title;

  ComplicatedObject({required this.number, required this.title});
}

//自定义监听对象属性
class ComplicatedObjectNotifier extends ValueNotifier<ComplicatedObject> {
  ComplicatedObjectNotifier(ComplicatedObject object):super(object);

  void setTitle(String newTitle) {
    value.title = newTitle;
    notifyListeners(); //核心语句
  }
}

//单一方向拖动
class _DragVertical extends StatefulWidget {
  const _DragVertical({Key? key}) : super(key: key);

  @override
  State<_DragVertical> createState() => _DragVerticalState();
}

class _DragVerticalState extends State<_DragVertical> {
  double _top = 0.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _top,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A"),),
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
          ),
        )
      ],
    );
  }
}

//缩放
class _Scale extends StatefulWidget {
  const _Scale({Key? key}) : super(key: key);

  @override
  State<_Scale> createState() => _ScaleState();
}

class _ScaleState extends State<_Scale> {
  double _width = 200.0;
  double _height = 200.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(width: _width, height: _height,color: Colors.red,),
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            _width = 200*details.scale.clamp(.8, 10.0);
            _height = 200*details.scale.clamp(.8, 10.0);
          });
        },
      ),
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);
  final String msg;
}

class NotificationRoute extends StatefulWidget {
  const NotificationRoute({Key? key}) : super(key: key);

  @override
  State<NotificationRoute> createState() => _NotificationRouteState();
}

class _NotificationRouteState extends State<NotificationRoute> {

  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _msg += notification.msg + " ";
        });
        return true;
      },
      child: Column(
        children: [
          Container(
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => MyNotification("Hi").dispatch(context),
                  child: Text('Send Notification'),
                );
              },
            ),
          ),
          Text(_msg),
        ],
      ),
    );
  }
}

typedef void EventCallback(args);

class EventBus {
  EventBus._internal();

  static EventBus _singleton = EventBus._internal();

  factory EventBus()=>_singleton;

  final _emap = Map<Object, List<EventCallback>?>();

  void on(eventName, EventCallback f) {
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName]!.add(f);
  }

  void off(eventName, [EventCallback? f]) {
    var list = _emap[eventName];
    if(eventName == null || list == null) return;
    if(f == null){
      _emap[eventName] = null;
    }else{
      list.remove(f);
    }
  }

  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if(list == null) return;
    int len = list.length - 1;
    for(var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

var bus = EventBus();