import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

///
/// @File :path
/// @Class :PathWidget
/// @Author :yuzzha
/// @Date :2023/9/19 16:53
/// @TODO : path对象
///
class PathWidget extends StatefulWidget {
  const PathWidget({Key? key}) : super(key: key);

  @override
  _PathState createState() => _PathState();
}

class _PathState extends State<PathWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Path'),
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
                  painter: PathOvalPainter(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: SizedBox(
                width: 100,
                height: 100,
                child: CustomPaint(
                  painter: ArcToPainter(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidget(CustomPainter painter) {
    return CustomPaint(
      painter: painter,
    );
  }
}

///
///  椭圆 与 圆
///
///
class PathOvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //圆心点
    canvas.drawPoints(
        PointMode.points,
        [Offset(size.width / 2, size.height / 2)],
        Paint()
          ..color = Colors.red
          ..strokeWidth = 5.0
          ..style = PaintingStyle.fill
          ..strokeCap = StrokeCap.round);

    TextPainter textPainter = TextPainter()
      ..text = const TextSpan(
          text: '圆心', style: TextStyle(color: Colors.green, fontSize: 14.0))
      ..textDirection = TextDirection.ltr
      ..layout(maxWidth: 100);

    /// 绘制文字
    textPainter.paint(canvas,
        Offset(size.width / 2 - textPainter.width / 2, size.height / 2));

    Path path = Path();
    Rect oval = Rect.fromLTWH(0, 0, size.width, size.height);
    path.addOval(oval);
    ///矩形
    path.addRect(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: (size.width / 2) - 15));

   Rect rrect=  Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: (size.width / 2) - 25);
   ///圆角矩形
    path.addRRect(RRect.fromRectAndRadius(rrect,Radius.circular(10)));



    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..isAntiAlias = true);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

///
///  弧线 startAngle 开始角度 ， sweepAngle 旋转角度(改变角度不是旋转到那个角度)
///  void arcTo(Rect rect, double startAngle, double sweepAngle, bool forceMoveTo)
///  弧线
///  void addArc(Rect oval, double startAngle, double sweepAngle)
///
class ArcToPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    path.arcTo(rect, 0, 2 * pi / 4, true);

    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.lightGreenAccent
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke);

    Path path1 = Path();
    path1.moveTo(size.width / 2, size.height);
    path1.lineTo(size.width / 2, size.height / 2);
    path1.lineTo(size.width, size.height / 2);
    canvas.drawPath(
        path1,
        Paint()
          ..color = Colors.red
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke);

    Path path2 = Path();
    Rect oval2 = Rect.fromLTWH(0, 0, size.width, size.height);
    path2.addArc(oval2, -(2 * pi / 4), 2 * pi / 4);
    path2.addPolygon(<Offset>[
      Offset.zero,
      Offset(size.width, 0),
      Offset(size.width, size.height),
      Offset(0, size.width)
    ], false);

    canvas.drawPath(
        path2,
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..isAntiAlias = true);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
