
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DialogDemo extends StatefulWidget {
  const DialogDemo({Key? key}) : super(key: key);

  @override
  State<DialogDemo> createState() => _DialogDemoState();
}

class _DialogDemoState extends State<DialogDemo> {

  bool _withTree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("dialog Demo"),),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Dialog Demo"),
                SizedBox(height: 30.w,),
                InkWell(
                  onTap: () {
                    testDialog();
                  },
                  child: Text("test customDialog"),
                ),
                SizedBox(height: 30.w,),
                InkWell(
                  onTap: () {
                    testDialogDataDemo();
                  },
                  child: Text("test dialog data demo"),
                ),
                SizedBox(height: 30.w,),
                InkWell(
                  onTap: () {
                    showaLoadingDialog();
                  },
                  child: Text("test loading dialog demo"),
                ),
                SizedBox(height: 30.w,),
                StatefulBuilder(
                  builder: (context, _setState) {
                    return Checkbox(
                        value: _withTree,
                        onChanged: (value) {
                          _setState((){
                            _withTree = !_withTree;
                          });
                        }
                    );
                  },
                )
              ],
            ),
          ),
        )
    );
  }

  testDialogDataDemo () {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  Builder(
                    builder: (BuildContext context) {
                      return Checkbox(
                          value: _withTree,
                          onChanged: (value) {
                            (context as Element).markNeedsBuild();
                            _withTree = !_withTree;
                          }
                      );
                    },
                  ),
                  SizedBox(height: 30.w,),
                  Text("无法被选中啊!"),
                  Checkbox(
                      value: _withTree,
                      onChanged: (value) {
                        setState(() {
                          _withTree = !_withTree;
                        });
                      }
                  )
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("删除"),
              onPressed: () {
                // 执行删除操作
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }

  // 自定义弹窗宽度
  showaLoadingDialog () {
    showDialog(
        context: context,
        builder: (context) {
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: SizedBox(
              width: 280.w,
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 26.w),
                      child: Text("正在加载中，，，"),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  testDialog() {
    showCustomDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Container(
              child: Column(
                children: [
                  Text("你确定要删除当前文件吗"),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("取消")
              ),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("删除")
              ),
            ],
          );
        }
    );
  }
}


//封装一个showCustomDialog

Future showCustomDialog({
  required BuildContext context,
  bool barrierDismissible = true,
  required WidgetBuilder builder,
  ThemeData? theme,
}) {
  final ThemeData theme = Theme.of(context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder,);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null ?
              Theme(data: theme, child: pageChild,) : pageChild;
        },),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black87,
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions
  );
}

Widget _buildMaterialDialogTransitions(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut
    ),
    child: child,
  );
}


class StatefulBuilder extends StatefulWidget {
  final StatefulWidgetBuilder builder;

  const StatefulBuilder({
    Key? key,
    required this.builder
  }) : super(key: key);

  @override
  State<StatefulBuilder> createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, setState);
  }
}
