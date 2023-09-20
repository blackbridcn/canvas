import 'package:canvas/utils/image_utils.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

///
/// @File :image
/// @Class :ImageWidget
/// @Author :yuzzha
/// @Date :2023/9/15 11:51
/// @TODO :
///
class ImageWidget extends StatefulWidget {

  ui.Image image;

  ImageWidget(this.image, {Key? key}) : super(key: key);

  @override
  _ImageState createState() => _ImageState();
}

class _ImageState extends State<ImageWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: 600,
              height: 900,
              child: CustomPaint(
                painter: ImagePainter(widget.image),
              ),
            ),
            /*SizedBox(
                width: double.infinity,
                //height: 1800,
                child:*/
            CustomPaint(
              painter: ImageNinePainter(widget.image),
            )
            //),
          ],
        ),
      ),
    );
  }
}

class ImagePainter extends CustomPainter {

  ui.Image image;

  ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    // 原图片绘制
    canvas.drawImage(image, Offset.zero, paint..color = Colors.blue);

    ///
    ///拉伸和压缩部分区域绘制图片
    /// void drawImageNine(Image image, Rect center, Rect dst, Paint paint)
    ///
    Rect src = Rect.fromLTWH(
        image.width.toDouble() / 3,
        image.height.toDouble() / 3,
        image.width.toDouble() / 3 * 2,
        image.height.toDouble() / 3 * 2);
    Rect dst = Rect.fromLTWH(180, 180, image.width.toDouble() / 3 * 5,
        image.height.toDouble() / 3 * 5);
    canvas.drawImageNine(image, src, dst, paint);


    // 缩小图片尺寸绘制
    dst = Rect.fromLTWH(
        360, 360, image.width.toDouble(), image.height.toDouble());
    //canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class ImageNinePainter extends CustomPainter {
  ui.Image image;

  ImageNinePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    ///
    ///拉伸和压缩部分区域绘制图片
    /// void drawImageNine(Image image, Rect center, Rect dst, Paint paint)
    ///
    Rect src = Rect.fromLTWH(
        image.width.toDouble() / 3,
        image.height.toDouble() / 3,
        image.width.toDouble() / 3 * 2,
        image.height.toDouble() / 3 * 2);

    Rect dst = Rect.fromLTWH(0, 0, image.width.toDouble() / 3 * 5, image.height.toDouble() / 3 * 5);
    canvas.drawImageNine(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
