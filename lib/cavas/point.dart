import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

///
/// @File :point
/// @Class :PointWidget
/// @Author :yuzzha
/// @Date :2023/9/14 10:19
/// @TODO :
///
class PointWidget extends StatefulWidget {
  const PointWidget({Key? key}) : super(key: key);

  @override
  _PointState createState() => _PointState();

}

class _PointState extends State<PointWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Point'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomPaint(
            painter: PointPainter(),
          ),
        ],
      ),
    );
  }

}

///
/// 绘制画布背景
/// canvas.drawPaint(paint);
/// paint.color=Colors.green;
///
class PointPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.green;
    paint.strokeWidth = 10.0; //线条宽度
    paint.strokeCap=StrokeCap.round;
    ///
    /// 绘制画布背景颜色
    /// 通过 point 填充画布背景颜色
    /// void drawPaint(Paint paint) drawColor
    ///
    canvas.drawPaint(paint);

    double y = 15.0;

    double x0 = 10.0;
    double x1 = 30.0;
    double x2 = 50.0;
    double x3 = 70.0;

    List<Offset> points = [
      Offset(x0, y),
      Offset(x1, y),
      Offset(x2, y),
      Offset(x3, y)
    ];

    ///
    /// 绘制 点/线
    /// 通过 point 填充画布背景颜色
    /// void drawPoints(PointMode pointMode, List<Offset> points, Paint paint)
    ///  pointMode: 绘制方式
    ///    PointMode.points 点，单独绘制每个点
    ///    PointMode.lines 线段，每两个点连成一条线段
    ///    PointMode.polygon 线，所有的点连成一条线
    /// void drawRawPoints(PointMode pointMode, Float32List points, Paint paint)
    ///
    canvas.drawPoints(
        PointMode.points, points, paint..color = Colors.deepOrange);
    y = 35.0;
    points = [Offset(x0, y), Offset(x1, y), Offset(x2, y), Offset(x3, y)];
    canvas.drawPoints(PointMode.lines, points, paint..color = Colors.amber);

    y = 55.0;
    points = [Offset(x0, y), Offset(x1, y), Offset(x2, y), Offset(x3, y)];
    canvas.drawPoints(
        PointMode.points,
        points,
        paint
          ..color = Colors.purple
          ..strokeCap = StrokeCap.round);

    y = 75.0;
    points = [Offset(x0, y), Offset(x1, y), Offset(x2, y), Offset(x3, y)];
    canvas.drawPoints(
        PointMode.polygon,
        points,
        paint
          ..color = Colors.purple
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 5.0);

    y = 95.0;
    points = [
      Offset(x0, y),
      Offset(x1, y + 20),
      Offset(x2, y - 5),
      Offset(x3, y),
      Offset(x3 + 20, y + 20)
    ];
    canvas.drawPoints(
        PointMode.polygon,
        points,
        paint
          ..color = Colors.blue
          ..strokeWidth = 5.0
          ..strokeCap = StrokeCap.butt);

    y = 115.0;
    points = [
      Offset(x0, y),
      Offset(x1, y + 20),
      Offset(x2, y - 5),
      Offset(x3, y),
      Offset(x3 + 20, y + 20)
    ];
    canvas.drawPoints(
        PointMode.polygon,
        points,
        paint
          ..color = Colors.teal
          ..strokeWidth = 5.0
          ..strokeCap = StrokeCap.square);

    y = 135.0;
    points = [
      Offset(x0, y),
      Offset(x1, y + 20),
      Offset(x2, y - 5),
      Offset(x3, y),
      Offset(x3 + 20, y + 20)
    ];
    canvas.drawPoints(
        PointMode.polygon,
        points,
        paint
          ..color = Colors.red
          ..strokeWidth = 5.0
          ..strokeCap = StrokeCap.round);

    y = 165.0;
    //Float32List  list 同样是
    Float32List fpoints = Float32List.fromList(
        [x0, y + 10, x1, y - 5, x2, y + 30, x3, y, x3 + 30, y]);
    canvas.drawRawPoints(
        PointMode.polygon,
        fpoints,
        paint
          ..color = Colors.orange
          ..strokeWidth = 5.0
          ..strokeCap = StrokeCap.butt);

    y = 235.0;
    //Float32List  list 同样是
    fpoints = Float32List.fromList([x0, y + 10, x1, y - 5, x2, y + 30, x3, y, x3 + 30, y]);
    canvas.drawRawPoints(PointMode.polygon, fpoints, paint..color = Colors.orange..strokeWidth = 5.0..strokeCap = StrokeCap.round);

    ///
    /// 绘制线
    /// void drawLine(Offset p1, Offset p2, Paint paint)
    ///
    y = 275.0;
    canvas.drawLine(Offset(x0, y), Offset(x3, y), paint..color = Colors.indigoAccent);

    ///
    ///  设置Path绘制
    ///  void drawPath(Path path, Paint paint)
    ///
    Path path = Path();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
