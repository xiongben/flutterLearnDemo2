import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageViewDemo extends StatefulWidget {
  const PageViewDemo({Key? key}) : super(key: key);

  @override
  State<PageViewDemo> createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for(int i=0;i<6;++i) {
      children.add(KeepAliveWrapper(child: Page(text: '$i')));
    }
    return Scaffold(
        appBar: AppBar(title: Text("PageView Demo"),),
        body: SafeArea(
          child: PageView(
            allowImplicitScrolling: true,
            children: children,
          ),
        )
    );
  }
}


class Page extends StatefulWidget {
  final String text;
  const Page({Key? key, required this.text}) : super(key: key);

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page>{
  @override
  Widget build(BuildContext context) {
    print("build ${widget.text}");
    return Center(
      child: Text("${widget.text}", textScaleFactor: 5,),
    );
  }

}


class KeepAliveWrapper extends StatefulWidget {
  final bool keepAlive;
  final Widget child;
  const KeepAliveWrapper({
    Key? key,
    this.keepAlive = true,
    required this.child
  }) : super(key: key);

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if(oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => widget.keepAlive;
}
