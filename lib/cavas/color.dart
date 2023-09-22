

import 'package:flutter/material.dart';

///
/// @File :color
/// @Class :ColorWidget
/// @Author :yuzzha
/// @Date :2023/9/18 10:00
/// @TODO :
///
class ColorWidget extends StatefulWidget {
  const ColorWidget({Key? key}) : super(key: key);

  @override
  _ColorState createState() => _ColorState();
}

class _ColorState extends State<ColorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          /*SizedBox(
            width: 300,
            height: 500,
            child: CustomPaint(
              painter: ClearPainter(),
            ),
          ),*/
          SizedBox(
            width: 300,
            height: 500,
            child: CustomPaint(
              painter: ColorPainter(),
            ),
          ),

        ],
      ),
    );
  }
}

///
/// Color 背景颜色 , blendMode:颜色混合模式
/// void drawColor(Color color, BlendMode blendMode
///
class ColorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //
    canvas.drawColor(Colors.red, BlendMode.srcOver);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class ClearPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    //
    canvas.drawColor(Colors.blue, BlendMode.dstOver);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }

}
