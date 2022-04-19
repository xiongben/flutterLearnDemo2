import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstDemo extends StatefulWidget {
  const FirstDemo({Key? key}) : super(key: key);

  @override
  State<FirstDemo> createState() => _FirstDemoState();
}

class _FirstDemoState extends State<FirstDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("demo one"),),
      body: Container(
        width: 375.w,
        height: 100.w,
        color: Colors.yellow,
        child: Text("demo one"),
      ),
    );
  }
}
