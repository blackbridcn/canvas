import 'dart:ui';

import 'package:flutter/material.dart';

///
/// @File :shadow
/// @Class :ShadowWidget
/// @Author :yuzzha
/// @Date :2023/9/18 10:53
/// @TODO :
///
/// https://blog.csdn.net/Android23333/article/details/128801164
///
/// Flutter 绘出光影流动之美
/// https://www.modb.pro/db/636259
///
class ShadowWidget extends StatefulWidget {
  const ShadowWidget({Key? key}) : super(key: key);

  @override
  _ShadowState createState() => _ShadowState();
}

class _ShadowState extends State<ShadowWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shadow'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 200,
            height: 300,
            child: CustomPaint(
              painter: ShadowPainter(),
            ),
          ),

          SizedBox(
            width: 300,
            height: 300,
            child: CustomPaint(
              painter: RectShadowPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

///
/// path:阴影路径
/// color:阴影颜色
/// elevation:阴影的高度
/// transparentOccluder:官方文档上翻译过来意思是遮挡对象是否透明的。个人理解，因为阴影是一个光源在画布上方被遮挡时产生的，transparentOccluder 为false时，这个遮挡物是不透明的。
/// void drawShadow(Path path, Color color, double elevation, bool transparentOccluder)
///
class ShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    canvas.drawPoints(PointMode.points,[Offset(size.width/2, size.height/2)], paint..strokeWidth=10);

    Path path = Path();
    Rect rect1 = Rect.fromLTRB(20,20, size.width-20, size.height-20);

    path.addRect(rect1);

    /// transparentOccluder true :表示透明，false :不透明,感觉只是 elevation 阴影 层叠效果
   // canvas.drawShadow(path, Colors.green, 10, true);
    canvas.drawShadow(path, Colors.green, 10, false);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class RectShadowPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    Path path = Path();
    var rect = Rect.fromLTWH(size.width / 4, size.height / 4, size.width / 2, size.height / 4);
    path.addRect(rect);

    canvas.drawShadow(path, Colors.red, 20, false);
    Paint paint = Paint()..color = Colors.red;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
