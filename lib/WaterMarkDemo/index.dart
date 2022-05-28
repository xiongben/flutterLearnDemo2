import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;


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

  final WaterMarkPainter painter;
  final ImageRepeat repeat;

  const WaterMark({
    Key? key,
    this.repeat = ImageRepeat.repeat,
    required this.painter
  }) : super(key: key);

  @override
  State<WaterMark> createState() => _WaterMarkState();
}

class _WaterMarkState extends State<WaterMark> {
   late Future<MemoryImage> _memoryImageFuture;

  @override
  void initState() {
    // TODO: implement initState
    _memoryImageFuture = _getWaterMarkImage();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _memoryImageFuture.then((value) => value.evict());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void didUpdateWidget(covariant WaterMark oldWidget) {
    // TODO: implement didUpdateWidget
    if(widget.painter.runtimeType != oldWidget.painter.runtimeType || widget.painter.shouldRepaint(oldWidget.painter)) {
      //先释放之前的缓存
      _memoryImageFuture.then((value) => value.evict());
      //重新绘制并缓存
      _memoryImageFuture = _getWaterMarkImage();
    }
    super.didUpdateWidget(oldWidget);
  }

   // 离屏绘制单元水印并将绘制结果保存为图片缓存起来
  Future<MemoryImage> _getWaterMarkImage() async {
    // 创建一个 Canvas 进行离屏绘制，细节和原理请查看本书后面关于Flutter绘制原理相关章节
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final Size size = widget.painter.paintUnit(canvas);
    final picture = recorder.endRecording();
    //将单元水印导为图片并缓存起来
    final img = await picture.toImage(size.width.ceil(), size.height.ceil());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    return MemoryImage(pngBytes);
  }
}


abstract class WaterMarkPainter {
  // Size paintUnit(Canvas canvas, double devicePixelRatio);
  Size paintUnit(Canvas canvas);
  bool shouldRepaint(covariant WaterMarkPainter oldPainter) => true;
}


/// 文本水印画笔

class TextWaterMarkPainter extends WaterMarkPainter {
  TextWaterMarkPainter({
    Key? key,
    double? rotate,
    EdgeInsets? padding,
    TextStyle? textStyle,
    required this.text,
  }) : assert (rotate == null || rotate >= -90 || rotate <= 90),
       rotate = rotate??0,
       padding = padding??const EdgeInsets.all(10.0),
       textStyle = textStyle??TextStyle(color: Color.fromARGB(20, 0, 0, 0),fontSize: 14);

  double rotate;
  TextStyle textStyle;
  EdgeInsets padding;
  String text;


  // paintUnit 的绘制分两步：
  //
  // 1,绘制文本
  // 2,应用旋转和padding
  //
  // 文本的绘制三步：
  //
  // 1,创建一个 ParagraphBuilder，记为 builder。
  // 2,调用 builder.add 添加要绘制的字符串。
  // 3,构建文本并进行 layout，因为在 layout 后才能知道文本所占用的空间。
  // 4,调用 canvas.drawParagraph 绘制。

  @override
  Size paintUnit(Canvas canvas) {
    // TODO: implement paintUnit
    throw UnimplementedError();
  }

  @override
  bool shouldRepaint(covariant WaterMarkPainter oldPainter) {
    // TODO: implement shouldRepaint
    return super.shouldRepaint(oldPainter);
  }
}