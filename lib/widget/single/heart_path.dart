import 'dart:ui';

import 'package:flutter/material.dart';

///
/// @File :heart_painter
/// @Class :HeartPainterWidget
/// @Author :yuzzha
/// @Date :2023/9/22 15:10
/// @TODO :
///
class HeartPathWidget extends StatefulWidget {
  const HeartPathWidget({Key? key}) : super(key: key);

  @override
  _HeartPathState createState() => _HeartPathState();
}

class _HeartPathState extends State<HeartPathWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HeartPainter'),
      ),
      body: Center(
          child: SizedBox(
        width: 500,
        height: 300,
        child: CustomPaint(
          painter: HeartPainter(),
        ),
      )),
    );
  }
}

class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..moveTo(size.width / 2, size.height / 5)
      ..cubicTo(
          size.width / 3, 0, 0, size.height / 3.5, size.width / 2, size.height)
      ..cubicTo(size.width, size.height / 3.5, size.width * 2 / 3, 0,
          size.width / 2, size.height / 5);

    canvas.drawPath(path, paint);

    canvas.drawPoints(
        PointMode.points,
        <Offset>[
          Offset(size.width / 3, 0),
          Offset(0, size.height / 3.5),
          Offset(size.width / 2, size.height),
        ],
        paint..color = Colors.blue..strokeWidth=10.0);

    canvas.drawPoints(
        PointMode.points,
        <Offset>[
          Offset(size.width, size.height / 3.5),
          Offset(size.width * 2 / 3, 0),
          Offset(size.width / 2, size.height / 5),
        ],
        paint..color = Colors.purple..strokeWidth=10.0);

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        paint..color = Colors.green..strokeWidth=1.0);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
