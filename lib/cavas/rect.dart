import 'package:flutter/material.dart';

///
/// @File :rect
/// @Class :RectWidget
/// @Author :yuzzha
/// @Date :2023/9/14 17:54
/// @TODO :
///
class RectWidget extends StatefulWidget {
  const RectWidget({Key? key}) : super(key: key);

  @override
  _RectState createState() => _RectState();
}

class _RectState extends State<RectWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rect'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: CustomPaint(
              painter: RectPointer(),
            ),
          ),
          SizedBox(
            width: 300,
            height: 300,
            child: CustomPaint(
              painter: RRectPointer(),
            ),
          )
        ],
      ),
    );
  }
}

class RectPointer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //四个点坐标
    Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    Paint paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawRect(rect, paint);
    //left 和 top 坐标 , width height
    rect = Rect.fromLTWH(size.width / 2, size.height / 2, size.width / 2, size.height / 2);

    canvas.drawRect(rect, paint..color = Colors.yellowAccent..style = PaintingStyle.fill);
    //圆心坐标和半径
    rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 4);
    canvas.drawRect(
        rect,
        paint
          ..color = Colors.redAccent
          ..style = PaintingStyle.fill);

    //对角线坐标
    rect =
        Rect.fromPoints(Offset(0, 0), Offset(size.width / 2, size.height / 2));
    canvas.drawRect(
        rect,
        paint
          ..color = Colors.green
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class RRectPointer extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;

    RRect rRect = RRect.fromLTRBAndCorners(0, 0, size.width, size.height, topLeft: const Radius.elliptical(10, 10),);
    canvas.drawRRect(rRect, paint..color = Colors.teal);

    rRect = RRect.fromLTRBAndCorners(0, 0, size.width, size.height, topLeft: const Radius.elliptical(10, 10),);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }

}
