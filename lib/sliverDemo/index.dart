import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

class _SliverFlexibleHeader extends SingleChildRenderObjectWidget {

  final double visibleExtent;

  const _SliverFlexibleHeader({
    Key? key,
    required Widget child,
    this.visibleExtent = 0
  }): super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _FlexibleHeaderRenderSliver(visibleExtent);
  }

  @override
  void updateRenderObject(BuildContext context, _FlexibleHeaderRenderSliver renderObject) {
    renderObject..visibleExtent = visibleExtent;
  }

}


class _FlexibleHeaderRenderSliver extends RenderSliverSingleBoxAdapter {

  _FlexibleHeaderRenderSliver(double visibleExtent)
      : _visibleExtent = visibleExtent;

  double _lastOverScroll = 0;
  double _lastScrollOffset = 0;
  late double _visibleExtent = 0;
  ScrollDirection _direction = ScrollDirection.idle;

  set visibleExtent(double value) {
    // 可视长度发生变化，更新状态并重新布局
    if(_visibleExtent != value) {
      _lastOverScroll = 0;
      _visibleExtent = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    // 滑动距离大于_visibleExtent时则表示子节点已经在屏幕之外了
    if(child == null || (constraints.scrollOffset > _visibleExtent)) {
      geometry = SliverGeometry(scrollExtent: _visibleExtent);
      return;
    }

    double overScroll = constraints.overlap < 0 ? constraints.overlap.abs() : 0;
    var scrollOffset = constraints.scrollOffset;

    // 根据前后的overScroll值之差确定列表滑动方向。注意，不能直接使用 constraints.userScrollDirection，
   // 这是因为该参数只表示用户滑动操作的方向。比如当我们下拉超出边界时，然后松手，此时列表会弹回，即列表滚动
   // 方向是向上，而此时用户操作已经结束，ScrollDirection 的方向是上一次的用户滑动方向(向下)，这是便有问题。
    var distance = overScroll > 0
        ? overScroll - _lastOverScroll
        : _lastScrollOffset - scrollOffset;
    _lastOverScroll = overScroll;
    _lastScrollOffset = scrollOffset;

    if (constraints.userScrollDirection == ScrollDirection.idle) {
      _direction = ScrollDirection.idle;
      _lastOverScroll = 0;
    } else if (distance > 0) {
      _direction = ScrollDirection.forward;
    } else if (distance < 0) {
      _direction = ScrollDirection.reverse;
    }

    // 在Viewport中顶部的可视空间为该 Sliver 可绘制的最大区域。
    // 1. 如果Sliver已经滑出可视区域则 constraints.scrollOffset 会大于 _visibleExtent，
    //    这种情况我们在一开始就判断过了。
    // 2. 如果我们下拉超出了边界，此时 overScroll>0，scrollOffset 值为0，所以最终的绘制区域为
    //    _visibleExtent + overScroll.

    double paintExtent = _visibleExtent + overScroll - constraints.scrollOffset;
    // 绘制高度不超过最大可绘制空间
    paintExtent = min(paintExtent, constraints.remainingPaintExtent);

    child!.layout(
      ExtraInfoBoxConstraints(_direction, constraints.asBoxConstraints(maxExtent: paintExtent)),
      parentUsesSize: false
    );
    //最大为_visibleExtent，最小为 0
    double layoutExtent = min(_visibleExtent, paintExtent);

    geometry = SliverGeometry(
      scrollExtent: layoutExtent,
      paintOrigin: -overScroll, // 绘制的坐标原点，相对于自身布局位置
      paintExtent: paintExtent, // 可视区域中的绘制长度
      maxPaintExtent: paintExtent, //最大绘制长度
      layoutExtent: layoutExtent
    );
  }
}

typedef SliverFlexibleHeaderBuilder = Widget Function(
      BuildContext context,
      double maxExtent,
      ScrollDirection direction
    );

class SliverFlexibleHeader extends StatelessWidget {
  const SliverFlexibleHeader({
    Key? key,
    this.visibleExtent = 0,
    required this.direction,
    required this.builder
  }): super(key: key);

  final SliverFlexibleHeaderBuilder builder;
  final double visibleExtent;
  final ScrollDirection direction;

  @override
  Widget build(BuildContext context) {
    return _SliverFlexibleHeader(
      visibleExtent: visibleExtent,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return builder(
            context,
            constraints.maxHeight,
            (constraints as ExtraInfoBoxConstraints<ScrollDirection>).extra,
          );
        },
      ),
    );
  }
}

class ExtraInfoBoxConstraints<T> extends BoxConstraints {
  ExtraInfoBoxConstraints(
      this.extra,
      BoxConstraints constraints,
      ) : super(
    minWidth: constraints.minWidth,
    minHeight: constraints.minHeight,
    maxWidth: constraints.maxWidth,
    maxHeight: constraints.maxHeight,
  );

  // 额外的信息
  final T extra;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ExtraInfoBoxConstraints &&
        super == other &&
        other.extra == extra;
  }

  @override
  int get hashCode {
    return hashValues(super.hashCode, extra);
  }
  // 我们重载了“==”运算符，这是因为 Flutter 在布局期间在特定的情况下会检测前后两次 constraints 是否相等然后来决定是否需要重新布局，
  // 所以我们需要重载“==”运算符，否则可能会在最大/最小宽高不变但 extra 发生变化时不会触发 child 重新布局，这时也就不会触发 LayoutBuilder，
  // 这明显不符合预期，因为我们希望 extra 发生变化时，会触发 LayoutBuilder 重新构建 child。
}