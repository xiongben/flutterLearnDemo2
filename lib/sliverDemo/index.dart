import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//自定义Sliver

// Sliver 的布局协议如下：
//
// Viewport 将当前布局和配置信息通过 SliverConstraints 传递给 Sliver。
// Sliver 确定自身的位置、绘制等信息，保存在 geometry 中（一个 SliverGeometry 类型的对象）。
// Viewport 读取 geometry 中的信息来对 Sliver 进行布局和绘制。

// Sliver布局模型和盒布局模型
// 两者布局流程基本相同：父组件告诉子组件约束信息 > 子组件根据父组件的约束确定自生大小 > 父组件获得子组件大小调整其位置。不同是：
//
// 父组件传递给子组件的约束信息不同。盒模型传递的是 BoxConstraints，而 Sliver 传递的是 SliverConstraints。
// 描述子组件布局信息的对象不同。盒模型的布局信息通过 Size 和 offset描述 ，而 Sliver的是通过 SliverGeometry 描述。
// 布局的起点不同。Sliver布局的起点一般是Viewport ，而盒模型布局的起点可以是任意的组件。

class SliverDemo extends StatefulWidget {
  const SliverDemo({Key? key}) : super(key: key);

  @override
  State<SliverDemo> createState() => _SliverDemoState();
}

class _SliverDemoState extends State<SliverDemo> {
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
                Text("Demo Sliver"),
              ],
            ),
          ),
        )
    );
  }
}
