
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PointerDemo extends StatefulWidget {
  const PointerDemo({Key? key}) : super(key: key);

  @override
  State<PointerDemo> createState() => _PointerDemoState();
}

class _PointerDemoState extends State<PointerDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("demo pointer"),),
        body: SafeArea(
          child: Column(
            children: [
              Text("888888")
            ],
          ),
        )
    );
  }
}
