import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_flutter/demoFour/index.dart';

class FiveDemo extends StatefulWidget {
  const FiveDemo({Key? key}) : super(key: key);

  @override
  State<FiveDemo> createState() => _FiveDemoState();
}

class _FiveDemoState extends State<FiveDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("demo five"),),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Demo Five"),
                SizedBox(height: 50.w,),
                Container(
                  color: Colors.yellow,
                  child: Transform(
                    alignment: Alignment.topRight,
                    transform: Matrix4.skewY(0.3),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.orange,
                      child: Text("this is a test"),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(
                      builder: (context)=> FourDemo()
                    ));
                  },
                  child: Text("to other page"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 1000),
                        pageBuilder: (BuildContext context, Animation<double> animation, Animation secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: FourDemo(),
                          );
                        }
                      )
                    );
                  },
                  child: Text("to other page"),
                ),
              ],
            ),
          ),
        )
    );
  }
}
