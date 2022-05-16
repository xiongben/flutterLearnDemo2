import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_flutter/demoFour/index.dart';

class ProviderDemo extends StatefulWidget {
  const ProviderDemo({Key? key}) : super(key: key);

  @override
  State<ProviderDemo> createState() => _ProviderDemoState();
}

class _ProviderDemoState extends State<ProviderDemo> {
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
                Text("Provider Demo"),
                SizedBox(height: 50.w,),
              ],
            ),
          ),
        )
    );
  }
}
class InheritedProvider<T> extends InheritedWidget {

  final T data;

  InheritedProvider({
    required this.data,
    required Widget child,
  }):super(child: child);

  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    return true;
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {

  final Widget child;
  final T data;

  const ChangeNotifierProvider({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {

  void update() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


