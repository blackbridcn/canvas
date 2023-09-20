import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

///
/// @File :test
/// @Class :TestWidget
/// @Author :yuzzha
/// @Date :2023/9/19 18:26
/// @TODO : 文本绘制
///
///
///
class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: SizedBox(
                width: 100,
                height: 100,
                child: CustomPaint(
                  painter: ParagraphPainter(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: SizedBox(
                width: 100,
                height: 100,
                child: CustomPaint(
                  painter: TextSpanPainter(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
/// drawParagraph绘制文字
///
/// 通过ParagraphBuilder构造基本样式 pushStyle和添加文字 addText.builder.build（）可以创建Paragraph对象，
///
/// 之后必须对layout限制区域，
///
/// 下面的蓝色区域是绘制的辅助，依次是左对齐、居中、右对齐。
///
class ParagraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    ParagraphBuilder builder = ParagraphBuilder(ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: 40,
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '~'));

    builder.pushStyle(ui.TextStyle(
      color: Colors.green,
      fontSize: 12.9,
      fontWeight: FontWeight.w600,
      fontStyle: ui.FontStyle.italic,
      shadows: <Shadow>[
        Shadow(
          color: Colors.green,
          offset: Offset(5, 5),
          blurRadius: 5,
        )
      ],
    ));
    builder.addText("ParagraphBuilder Text");

    ui.Paragraph paragraph = builder.build();

    paragraph.layout(ui.ParagraphConstraints(width: size.width));

    canvas.drawParagraph(paragraph, Offset.zero);

    //蓝色区域是绘制的辅助，依次是左对齐、居中、右对齐。
    //canvas.drawRect(Rect.fromLTRB(0, 0, 160, 40 ), Paint()..color = Colors.blue.withAlpha(33));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class TextSpanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    TextPainter painter = TextPainter(
      text: TextSpan(
          text: "TextSpanPainter",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.red,
          shadows: [Shadow(offset: Offset(4,4),blurRadius:2.0)],
          )),
      textDirection: TextDirection.ltr,
        ellipsis:"~~"
    );
    //layout 布局计算
    painter.layout();
    //画布paint
    painter.paint(canvas, Offset.zero); // 进行绘制

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
