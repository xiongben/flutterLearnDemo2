import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FourDemo extends StatefulWidget {
  const FourDemo({Key? key}) : super(key: key);

  @override
  State<FourDemo> createState() => _FourDemoState();
}

class _FourDemoState extends State<FourDemo> {

  double _linearVal = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("demo tree"),),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.w,),
                LinearComponent(
                  val: _linearVal,
                ),
                SizedBox(height: 50.w,),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow)
                  ),
                  onPressed: () {
                    var num = new Random();
                    var _newNum = num.nextDouble();
                    print(_newNum);
                    setState(() {
                      _linearVal = _newNum;
                    });
                  },
                  child: Text("刷新页面"),
                )
              ],
            ),
          ),
        )
    );
  }
}

class LinearComponent extends StatefulWidget {

  final double val;

  const LinearComponent({
    Key? key,
    this.val = .1
  }) : super(key: key);

  @override
  State<LinearComponent> createState() => _LinearComponentState();
}

class _LinearComponentState extends State<LinearComponent> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000)
    );
    _animation = Tween(begin: 0.0, end: widget.val).animate(_controller)
    ..addListener(() {
      setState(() {

      });
    });
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant LinearComponent oldWidget) {
    // TODO: implement didUpdateWidget
    print("==========");
    print(widget.val);
    print("==========");
    _controller.reset();
    _animation = Tween(begin: 0.0, end: widget.val).animate(_controller)
      ..addListener(() {
        setState(() {

        });
      });
    _controller.forward();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // color: Colors.yellow,
      child: Column(
        children: [
          Container(
            height: 10.w,
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: _animation.value,
            ),
          ),
          Text(widget.val.toString())
        ],
      ),
    );
  }
}

