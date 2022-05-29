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

  PointerEvent? _event;
  bool _testStatus = false;
  int _counter = 0;
  ValueNotifier<int> _notifier = ValueNotifier<int>(0);  //监听变量
  
  void _incrementCounter() {
    _counter++;
    _notifier.value++;
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("event Demo"),
                SizedBox(height: 30.w,),
                ValueListenableBuilder(
                  valueListenable: _notifier,
                  builder: (BuildContext context, int value, _) {
                    return Container(
                      child: Text('you have pushed the button this many times:$value'),
                    );
                  },
                ),
                Text(_counter.toString()),
                ElevatedButton(
                    onPressed: _incrementCounter,
                    child: Text("add")
                ),
                SizedBox(height: 30.w,),
                Text(_testStatus.toString()),
                ElevatedButton(
                    onPressed: () {
                      print(_testStatus);
                      setState(() {
                        _testStatus = !_testStatus;
                      });
                      print(_testStatus);
                    },
                    child: Text("testFn")
                ),

                SizedBox(height: 30.w,),
                Listener(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.blue,
                    width: 300.w,
                    height: 150.w,
                    child: Text(
                      "${_event?.localPosition ?? '位置'}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPointerDown: (PointerDownEvent event) {
                    setState(() {
                      _event = event;
                    });
                  },
                  onPointerMove: (PointerMoveEvent event) => setState(()=>_event = event),
                  onPointerUp: (PointerUpEvent event) => setState(()=>_event = event),
                )
              ],
            ),
          ),
        )
    );
  }
}
