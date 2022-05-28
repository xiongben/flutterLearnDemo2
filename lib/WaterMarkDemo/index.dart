import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
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
            child: wTextWaterMark(),
          ),
        )
    );
  }

  Widget wTextWaterMark() {
    return Stack(
      children: [
        Center(
          child: ElevatedButton(
            child: const Text('按钮'),
              onPressed: () => print('tab'),
            ),
        ),
        IgnorePointer(
          child: Container(
            child: WaterMark(
              painter: TextWaterMarkPainter(
                text: 'Flutter 中国 @wendux',
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  color: Colors.black38, //为了水印能更清晰一些，颜色深一点
                ),
                rotate: -20, // 旋转 -20 度
              ),
            ),
          ),
        ),
      ],
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
     return SizedBox.expand( // 水印尽可能大
       child: FutureBuilder(
         future: _memoryImageFuture,
         builder: (BuildContext context, AsyncSnapshot snapshot) {
           if (snapshot.connectionState != ConnectionState.done) {
             // 如果单元水印还没有绘制好先返回一个空的Container
             return Container();
           } else {
             // 如果单元水印已经绘制好，则渲染水印
             return DecoratedBox(
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: snapshot.data, // 背景图，即我们绘制的单元水印图片
                   repeat: widget.repeat, // 指定重复方式
                   alignment: Alignment.topLeft,
                 ),
               ),
             );
           }
         },
       ),
     );
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
    final Size size = widget.painter.paintUnit(canvas, 2.75);
    final picture = recorder.endRecording();
    //将单元水印导为图片并缓存起来
    final img = await picture.toImage(size.width.ceil(), size.height.ceil());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    return MemoryImage(pngBytes);
  }
}


abstract class WaterMarkPainter {
  Size paintUnit(Canvas canvas, double devicePixelRatio);
  // Size paintUnit(Canvas canvas);
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
  Size paintUnit(Canvas canvas, double devicePixelRatio) {
    //根据屏幕 devicePixelRatio 对文本样式中长度相关的一些值乘以devicePixelRatio
    final _textStyle = _handleTextStyle(textStyle, devicePixelRatio);
    final _padding = padding * devicePixelRatio;

    // //构建文本段落
    // final builder = ui.ParagraphBuilder(_textStyle.getParagraphStyle(
    //   textDirection: TextDirection.ltr,
    //   textAlign: TextAlign.center,
    //   textScaleFactor: devicePixelRatio
    // ));
    //
    // //添加要绘制的文本及样式
    // builder
    //   ..pushStyle(_textStyle.getTextStyle()) // textStyle 为 ui.TextStyle
    //   ..addText(text);
    //
    // //layout 后我们才能知道文本占用的空间
    // ui.Paragraph paragraph = builder.build()
    //   ..layout(ui.ParagraphConstraints(width: double.infinity));
    //
    // //文本占用的真实宽度
    // final textWidth = paragraph.longestLine.ceilToDouble();
    // //文本占用的真实高度
    // final fontSize = paragraph.height;
    //
    // //绘制文本
    // canvas.drawParagraph(paragraph, Offset.zero);


    //构建文本画笔
    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
      textScaleFactor: devicePixelRatio,
    );
    //添加文本和样式
    painter.text = TextSpan(text: text, style: _textStyle);
    //对文本进行布局
    painter.layout();

    //文本占用的真实宽度
    final textWidth = painter.width;
    //文本占用的真实高度
    final fontSize = painter.height;

    // 将弧度转化为度数
    final radians = math.pi * rotate / 180;

    //通过三角函数计算旋转后的位置和size
    final orgSin = math.sin(radians);
    final sin = orgSin.abs();
    final cos = math.cos(radians).abs();

    final width = textWidth * cos;
    final height = textWidth * sin;
    final adjustWidth = fontSize * sin;
    final adjustHeight = fontSize * cos;

    // 为什么要平移？下面解释
    if (orgSin >= 0) { // 旋转角度为正
      canvas.translate(
        adjustWidth + padding.left,
        padding.top,
      );
    } else { // 旋转角度为负
      canvas.translate(
        padding.left,
        height + padding.top,
      );
    }
    canvas.rotate(radians);

    // 绘制文本
    painter.paint(canvas, Offset.zero);

    // 返回水印单元所占的真实空间大小（需要加上padding）
    return Size(
      width + adjustWidth + padding.horizontal,
      height + adjustHeight + padding.vertical,
    );

  }

  @override
  bool shouldRepaint(TextWaterMarkPainter oldPainter) {
    return oldPainter.rotate != rotate ||
        oldPainter.text != text ||
        oldPainter.padding != padding ||
        oldPainter.textStyle != textStyle;
  }

  TextStyle _handleTextStyle(TextStyle textStyle,double devicePixelRatio) {
    var style = textStyle;
    double _scale(attr) => attr == null ? 1.0 : devicePixelRatio;
    return style.apply(
      decorationThicknessFactor: _scale(style.decorationThickness),
      letterSpacingFactor: _scale(style.letterSpacing),
      wordSpacingFactor: _scale(style.wordSpacing),
      heightFactor: _scale(style.height)
    );
  }
}