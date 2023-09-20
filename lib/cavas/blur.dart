import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:ui' as ui;

///
/// @File :blur
/// @Class :BlurWidget
/// @Author :yuzzha
/// @Date :2023/9/19 10:56
/// @TODO :
///
class BlurWidget extends StatefulWidget {

  ui.Image image;

  BlurWidget(this.image, {Key? key}) : super(key: key);

  @override
  _BlurState createState() => _BlurState();
}

class _BlurState extends State<BlurWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blur'),
      ),
      body: Center(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
          child: Image.asset('images/ic_launcher.png'),
        ),

        /*ImageFiltered(
          imageFilter: ImageFilter.compose(
              outer: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              inner: ImageFilter.matrix(Matrix4.skewX(math.pi / 4).storage)),
          child: Image.asset('images/ic_launcher.png'),
        ),*/
      ),
    );
  }
}

class BlurPainter extends CustomPainter {
  ui.Image image;

  BlurPainter(this.image);

  ///
  /// The following UnimplementedError was thrown during paint():
  /// ImageFilter.compose not implemented for CanvasKit.
  ///
  @override
  void paint(Canvas canvas, Size size) {
    //Paint paint = Paint()..imageFilter = ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0);

    Paint paint1 = Paint()
      ..imageFilter = ImageFilter.compose(
        outer: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
        inner: ImageFilter.matrix(Matrix4.rotationX(2.0).storage),
      );
    canvas.drawImage(image, Offset.zero, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
