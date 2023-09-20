import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:ui' as ui;

///
/// @File :paint
/// @Class :PaintWidget
/// @Author :yuzzha
/// @Date :2023/9/18 14:39
/// @TODO : 画笔
///
class PaintWidget extends StatefulWidget {
  ui.Image image;

  PaintWidget(this.image, {Key? key}) : super(key: key);

  @override
  _PaintState createState() => _PaintState();
}

class _PaintState extends State<PaintWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paint'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
                width: 300,
                height: 300,
                child: CustomPaint(
                  painter: StrokeJoinPainter(),
                )),
            SizedBox(
              width: 300,
              height: 300,
              child: CustomPaint(
                painter: ShaderPainter(),
              ),
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: CustomPaint(
                painter: BlurFilterPainter(widget.image),
              ),
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: CustomPaint(
                painter: ColorFilterPainter(widget.image),
              ),
            ),
            /*SizedBox(
              width: 300,
              height: 300,
              child:*/
            CustomPaint(
              painter: MatrixFilterPainter(widget.image),
            ),

            //),
            /*SizedBox(
              width:300,
              height: 300,
              child:
            CustomPaint(
              painter: ComposeFilterPainter(widget.image),
            ),
            ),*/
          ],
        ),
      ),
    );
  }
}

///
/// strokeJoin 拐角的形状
/// miter: 尖角
/// round: 圆角
/// bevel: 斜角
/// 适用于style设置为PaintingStyle.stroke时绘制的路径，不适用于使用Canvas.drawPoints绘制为线条的点。
/// 默认为StrokeJoin.miter ，即尖角
///
///
///
/// strokeMiterLimit:链接点斜接的限制
///
class StrokeJoinPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    ///三角形 0
    /// StrokeJoin.miter 尖角
    Path path = Path();
    path.moveTo(size.width / 3, 0);
    path.lineTo(size.width / 3, size.height / 3);
    path.lineTo(10, size.height / 3);
    path.lineTo(size.width / 3, 0);

    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.miter;
    canvas.drawPath(path, paint);

    ///三角形 1
    /// StrokeJoin.round 圆角
    Path path1 = Path();
    path1.moveTo((size.width / 3) * 2, 0);
    path1.lineTo(size.width / 3 + 10, size.height / 3);
    path1.lineTo(size.width - 10, size.height / 3);
    path1.lineTo((size.width / 3) * 2, 0);

    Paint paint1 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path1, paint1);

    ///三角形 2
    /// StrokeJoin.bevel 斜角
    Path path2 = Path();
    path2.moveTo(size.width / 2, size.height / 3 + 10);
    path2.lineTo(10, size.height - 10);
    path2.lineTo(size.width - 10, size.height - 10);
    path2.lineTo(size.width / 2, size.height / 3 + 10);

    Paint paint2 = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel;
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

///
/// 设置渐变和图片着色器
/// Paint.shader
/// ui.Gradient.linear
/// ImageShader
///
/// colorFilter ：着色器
/// invertColors:颜色反转
///
class ShaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    ///
    ///  Gradient.linear(
    ///     Offset from,
    ///     Offset to,
    ///     List<Color> colors, [
    ///     List<double>? colorStops,
    ///     TileMode tileMode = TileMode.clamp,
    ///     Float64List? matrix4,
    ///   ])
    ///   TileMode
    ///   以下是几种延伸模式的官方例子
    /// https://juejin.cn/post/7020629602343059492
    ///
    var paint = Paint()
      ..style = PaintingStyle.fill
      // 线性渐变
      ..shader = ui.Gradient.linear(
          Offset.zero,
          Offset(size.width / 3, 0),
          [Colors.red, Colors.green, Colors.blue, Colors.purpleAccent],
          [0, .3, 0.6, 1]);
    Rect rect = Rect.fromLTRB(0, 0, size.width / 3, size.height);
    //canvas.drawPaint(paint);
    canvas.drawRect(rect, paint);

    var paint1 = Paint()
      ..style = PaintingStyle.fill
      // radial 径向渐变
      ..shader = ui.Gradient.radial(
          Offset(size.width / 2, size.height / 2),
          size.width / 6,
          [Colors.red, Colors.teal, Colors.blue, Colors.green],
          [0, .3, .6, 1]);
    Rect rect1 = Rect.fromLTWH(size.width / 3, 0, size.width / 3, size.height);
    // canvas.drawPaint(paint1);
    canvas.drawRect(rect1, paint1);

    var paint2 = Paint()
      ..style = PaintingStyle.fill
      // sweep 扫描渐变
      ..shader = ui.Gradient.sweep(
          Offset(size.width / 6 * 5, size.height / 2),
          [Colors.teal, Colors.red, Colors.blue, Colors.yellow],
          [0, .3, .6, 1]);
    Rect rect2 =
        Rect.fromLTWH(size.width / 3 * 2, 0, size.width / 3, size.height);
    canvas.drawRect(rect2, paint2);
    // canvas.drawPaint(paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

///
///
///  imageFilter:图片处理的过滤器，可以实现图片模糊、矩阵变换等效果
///
/// ImageFilter.blur 高斯模糊
///
class BlurFilterPainter extends CustomPainter {
  ui.Image image;

  BlurFilterPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..imageFilter = ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5); //ui.ImageFilter.matrix(Matrix4.rotationY(2).storage);
    canvas.drawImage(image, Offset.zero, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

///
/// ImageFilter.matrix 矩阵变换
///
class MatrixFilterPainter extends CustomPainter {
  ui.Image image;

  MatrixFilterPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..imageFilter = ui.ImageFilter.matrix(
          Matrix4.rotationY(image.width.toDouble()).storage);
    //
    canvas.drawImage(image, Offset.zero, paint);
    //原图
    canvas.drawImage(image, Offset.zero,
        Paint()..imageFilter = ImageFilter.blur(sigmaY: 3.0, sigmaX: 3.0));
    // 向上面
    canvas.drawImage(
        image,
        Offset.zero,
        Paint()
          ..imageFilter = ui.ImageFilter.matrix(
              Matrix4.rotationX(image.height.toDouble()).storage));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class ColorFilterPainter extends CustomPainter {
  ui.Image image;

  ColorFilterPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    //Paint paint = Paint()..colorFilter = ColorFilter.linearToSrgbGamma();
    Paint paint = Paint()
      ..colorFilter = ColorFilter.mode(Colors.deepOrange, BlendMode.color);
    canvas.drawImage(image, Offset.zero, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

///
/// 组合
///
class ComposeFilterPainter extends CustomPainter {
  ui.Image image;

  ComposeFilterPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..imageFilter = ui.ImageFilter.compose(
        outer: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
        inner: ui.ImageFilter.matrix(Matrix4.rotationX(2.0).storage),
      );
    /*   canvas.drawPoints(
      PointMode.points,
      [Offset(size.width / 2, size.height / 2)],
      Paint()..color = Colors.lightGreenAccent,
    );*/
    canvas.drawImage(image, Offset.zero, paint);
    //canvas.drawImage(image, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
