import 'package:flutter/material.dart';

///
/// @File :oval
/// @Class :OvalWidget
/// @Author :yuzzha
/// @Date :2023/9/15 10:53
/// @TODO :
///
class OvalWidget extends StatefulWidget {
  const OvalWidget({Key? key}) : super(key: key);

  @override
  _OvalState createState() => _OvalState();
}

class _OvalState extends State<OvalWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oval'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 300,
            height: 500,
            child: CustomPaint(
              painter: OvalPainter(),
            ),
          ),
        ],
      ),
    );
  }
}


///
/// 椭圆
/// rect 长方形时 - 椭圆 ； rect正方形时 - 圆
/// void drawOval(Rect rect, Paint paint)
///
class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.yellowAccent;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
