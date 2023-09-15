import 'dart:math';

import 'package:flutter/material.dart';

///
/// @File :circle
/// @Class :CircleWidget
/// @Author :yuzzha
/// @Date :2023/9/13 15:17
/// @TODO :
///
class CircleWidget extends StatelessWidget {
  const CircleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 600.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Circle"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: CirclePainter(),
              ),
            ),
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: ArcPainter(),
              ),
            ),
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: ArcCenterPainter(),
              ),
            ),


            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: LineArcPainter(),
              ),
            ),
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: RectLerpArcPainter(),
              ),
            ),
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: RectLtrbLerpArcPainter(),
              ),
            ),
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: ConCirclePainter(),
              ),
            ),
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: CircleInnerFourPainter(),
              ),
            ),
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: CircleInnerFivePainter(),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

///
///  Canvas: 直接绘制一个圆
///  void drawCircle(Offset c, double radius, Paint paint)
///
class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.red;
    double radius =
        size.width >= size.height ? size.height / 2 : size.width / 2;
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

///
///  Canvas: 直接绘制一个半圆弧
///  void drawArc(Rect rect, double startAngle, double sweepAngle, bool useCenter, Paint paint)
///
class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.red;

    double radius = size.width >= size.height ? size.height / 2 : size.width / 2;

    Rect rect = Rect.fromCircle(center: Offset(radius, radius), radius: radius);

    double angle = (2 * pi / 4);
    //useCenter : 扇形或圆弧段（true或false）
    canvas.drawArc(rect, 0.0, angle, false, paint);
    canvas.drawArc(rect, angle, angle, true, paint..color = Colors.green);
    canvas.drawArc(rect, angle * 2, angle, false, paint..color = Colors.yellow);
    canvas.drawArc(rect, angle * 3, angle, true, paint..color = Colors.blue);

    Path path = Path();
    path.arcTo(rect, 2 * pi / 4, (2 * pi / 4) * 3, true);

    //canvas.drawColor(Colors.blue, BlendMode.srcOver);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

///
///空心扇形
///
/// 画笔描边
/// Paint.style = PaintingStyle.stroke
///
/// 圆弧 useCenter 占中/填充 为 true
/// canvas.drawArc(Rect rect, double startAngle, double sweepAngle, bool useCenter, Paint paint)
///
class ArcCenterPainter extends AbsPainter {

  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);
    // moveTo 移动到园心坐标
    Path path = Path();
    //..moveTo(radius, radius/2 )
    //Rect rect = Rect.fromLTRB(0, 0, radius,radius);
    Rect rect = Rect.fromLTWH(0, 0, radius * 2, radius * 2);

    //2 * pi  =360
  //  path.arcTo(rect, 0, 2 * pi / 4 * 3, true);

    // Paint .style :
    // PaintingStyle.fill :填充
    // PaintingStyle.stroke :镂空
    Paint paint = Paint()
      ..color = Colors.green
    //  ..blendMode = BlendMode.exclusion
      ..isAntiAlias = true
      ..strokeWidth = 0.0
      ..style = PaintingStyle.stroke;

    canvas.drawArc(rect, 2*pi/4*3, 2*pi/4 , true, paint);

    //canvas.drawArc(Rect.fromLTWH(160, 120, 150, 150), 3*pi/2, pi/3, true, paint);


  }
}


///
///  Canvas: 直接绘制一个3/4圆线
///  void drawPath(Path path, Paint paint)
///
class LineArcPainter extends AbsPainter {
  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);
    // moveTo 移动到园心坐标
    Path path = Path();
    //..moveTo(radius, radius/2 )
    //Rect rect = Rect.fromLTRB(0, 0, radius,radius);
    Rect rect = Rect.fromLTWH(0, 0, radius * 2, radius * 2);

    //2 * pi  =360
    path.arcTo(rect, 0, 2 * pi / 4 * 3, true);
    path.lineTo(radius, radius);
    path.lineTo(size.width, radius);

    // Paint .style :
    // PaintingStyle.fill :填充
    // PaintingStyle.stroke :镂空
    Paint paint = Paint()
      ..color = Colors.green
      //  ..blendMode = BlendMode.exclusion
      ..isAntiAlias = true
      ..strokeWidth = 0.0
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);
    // canvas.drawPaint(paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

///
/// Rect 在两个矩形之间进行线性插值
///
/// Linearly interpolate between two rectangles
///
/// static Rect? lerp(Rect? a, Rect? b, double t)
/// t:时间值（0.0~1.0之间）
///
class RectLerpArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 0.0
      //..style=PaintingStyle.stroke
      ..color = Colors.redAccent
      ..invertColors = false;

    //Rect.lerp(在两个矩形之间进行线性插值)
    Rect a = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 3);
    Rect b = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);

    //优先绘制半径更多大的扇形
    Rect? rect = Rect.lerp(a, b, 1.0);
    canvas.drawArc(rect!, 0.0, 2 * pi / 4, true, paint);

    //优先绘制半径更多大的扇形
    rect = Rect.lerp(a, b, 0.7);
    canvas.drawArc(rect!, 0.0, 2 * pi / 4, true, paint..color = Colors.brown);

    rect = Rect.lerp(a, b, 0.4);
    canvas.drawArc(rect!, 0.0, 2 * pi / 4, true, paint..color = Colors.yellow);

    rect = Rect.lerp(a, b, 0.1);
    canvas.drawArc(rect!, 0.0, 2 * pi / 4, true, paint..color = Colors.green);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

///
/// 偏心扇形
///
class RectLtrbLerpArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 0.0
      ..color = Colors.redAccent
      ..invertColors = false;
    double max = size.width / 4;
    double min = size.width / 5;

    Rect a = Rect.fromLTRB(0, 0, size.width - max, size.height - max);
    Rect b = Rect.fromLTRB(0, 0, size.width - min, size.height - min);

    Rect? rect = Rect.lerp(a, b, 1.0);
    canvas.drawArc(rect!, 0.0, 2 * pi / 4, true, paint);

    rect = Rect.lerp(a, b, 0.2);
    canvas.drawArc(rect!, 0.0, 2 * pi / 4, true, paint..color = Colors.blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

///
/// 同心园
///
class ConCirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 0.0
      ..color = Colors.redAccent
      ..invertColors = false;

    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 100.0);
    canvas.drawArc(rect, 0.0, 2 * pi, false, paint);

    rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 80.0);
    canvas.drawArc(rect, 0.0, 2 * pi, false, paint..color = Colors.blue);

    rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 60.0);
    canvas.drawArc(rect, 0.0, 2 * pi, false, paint..color = Colors.deepPurple);

    rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 40.0);
    canvas.drawArc(
        rect, 0.0, 2 * pi, false, paint..color = Colors.lightGreenAccent);

    rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 20.0);
    canvas.drawArc(rect, 0.0, 2 * pi, false, paint..color = Colors.grey);

    rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 10.0);
    canvas.drawArc(rect, 0.0, 2 * pi, false, paint..color = Colors.pinkAccent);

    rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 2.0);
    canvas.drawArc(rect, 0.0, 2 * pi, false, paint..color = Colors.blueAccent);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

abstract class AbsPainter extends CustomPainter {
  double radius = 0;

  @override
  void paint(Canvas canvas, Size size) {
    radius = size.width >= size.height ? size.height / 2 : size.width / 2;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

///
/// 同心园 渐变色
/// Opacity
///
class ConCirclePainter extends AbsPainter {
  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 0.0
      ..invertColors = false;

    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius);
    canvas.drawArc(rect, 0.0, 2 * pi, false,
        paint..color = Colors.redAccent.withOpacity(0.2));

    rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius - 10);
    canvas.drawArc(rect, 0.0, 2 * pi, false,
        paint..color = Colors.redAccent.withOpacity(0.3));

    rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius - 20);
    canvas.drawArc(rect, 0.0, 2 * pi, false,
        paint..color = Colors.redAccent.withOpacity(0.4));

    rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius - 30);
    canvas.drawArc(rect, 0.0, 2 * pi, false,
        paint..color = Colors.redAccent.withOpacity(0.5));

    rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius - 40);
    canvas.drawArc(rect, 0.0, 2 * pi, false,
        paint..color = Colors.redAccent.withOpacity(0.6));
  }
}

///
/// 画不同颜色等分弧度
///
///
class CircleInnerFourPainter extends AbsPainter {
  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 0.0
      ..invertColors = false;

    // Rect rect=Rect.fromCircle(center: Offset(size.width/2,size.height/2),radius: 100.0);
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawArc(rect, 0, 2 * pi / 4, true, paint..color = Colors.redAccent);

    rect = Rect.fromCircle(center: Offset(radius, radius), radius: radius);
    canvas.drawArc(
        rect, 2 * pi / 4, 2 * pi / 4, true, paint..color = Colors.yellow);

    rect = Rect.fromCircle(center: Offset(radius, radius), radius: radius);
    canvas.drawArc(
        rect, 2 * pi / 2, 2 * pi / 4, true, paint..color = Colors.green);

    rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius);
    canvas.drawArc(
        rect, 2 * pi / 4 * 3, 2 * pi / 4, true, paint..color = Colors.indigo);
  }
}

///
/// 五彩蜘蛛网
///
///
class CircleInnerFivePainter extends AbsPainter {
  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 0.0
      ..invertColors = false;

    for (int i = 0; i < 10; i++) {
      if(i%2==0){
        continue;
      }

      Rect rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 100.0);
      canvas.drawArc(rect, i * 2 * pi / 10, 2 * pi / 10, false, paint..color = Colors.indigo);

      rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 90.0);
      canvas.drawArc(rect, i * 2 * pi / 10, 2 * pi / 10, false, paint..color = Colors.grey);

      rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 80.0);
      canvas.drawArc(rect, i * 2 * pi / 10, 2 * pi / 10, false, paint..color = Colors.blueAccent);

      rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 70.0);
      canvas.drawArc(rect, i * 2 * pi / 10, 2 * pi / 10, false, paint..color = Colors.blue);

      rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 60.0);
      canvas.drawArc(rect, i * 2 * pi / 10, 2 * pi / 10, false, paint..color = Colors.purpleAccent);

      rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 50.0);
      canvas.drawArc(rect, i * 2 * pi / 10, 2 * pi / 10, false, paint..color = Colors.purple);

      rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 40.0);
      canvas.drawArc(rect, i * 2 * pi / 10, 2 * pi / 10, false, paint..color = Colors.pinkAccent);

      rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 30.0);
      canvas.drawArc(rect, i * 2 * pi / 10, 2 * pi / 10, false, paint..color = Colors.lightGreen);

      rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 20.0);
      canvas.drawArc(rect, i * 2 * pi / 10, 2 * pi / 10, false, paint..color = Colors.cyan);

      rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 10.0);
      canvas.drawArc(rect, i * 2 * pi / 10, 2 * pi / 10, false, paint..color = Colors.tealAccent);
    }
  }
}
