import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WaterMarkDemo extends StatefulWidget {
  const WaterMarkDemo({Key? key}) : super(key: key);

  @override
  State<WaterMarkDemo> createState() => _WaterMarkDemoState();
}

class _WaterMarkDemoState extends State<WaterMarkDemo> {
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
                Text("water mark demo")
              ],
            ),
          ),
        )
    );
  }
}

class WaterMark extends StatefulWidget {
  const WaterMark({Key? key}) : super(key: key);

  @override
  State<WaterMark> createState() => _WaterMarkState();
}

class _WaterMarkState extends State<WaterMark> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
