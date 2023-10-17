import 'package:flutter/material.dart';

///
/// @File :signature_widget
/// @Class :SignatureWidgetWidget
/// @Author :yuzzha
/// @Date :2023/10/12 17:48
/// @TODO :
///
class SignatureWidget extends StatefulWidget {
  Color backgroundColor;
  SignatureController controller;

  SignatureWidget(
    this.controller, {
    Key? key,
    this.backgroundColor = Colors.grey,
  }) : super(key: key);

  @override
  _SignatureState createState() => _SignatureState();
}

class _SignatureState extends State<SignatureWidget> {
  GlobalKey _globalKey = GlobalKey();

  ///
  /// Helper变量指示用户已经离开画布，这样我们就可以防止用直线链接下一个点。
  /// Helper variable indicating that user has left the canvas so we can prevent linking next point with straight line.
  ///
  bool _isOutsideDrawField = false;

  ///
  /// 活动指针可防止多点触摸绘图,
  /// Active pointer to prevent multitouch drawing
  ///
  /// 触摸事件id，防止同一个事件重复记录、绘制
  ///
  int? activePointerId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignatureWidget'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey[400]),
            child: Listener(
              onPointerDown: (PointerDownEvent event) {
                if (activePointerId == null || activePointerId == event.pointer) {
                    activePointerId = event.pointer;


                }
              },
              onPointerMove: (PointerMoveEvent event) {},
              onPointerUp: (PointerUpEvent event) {},
              onPointerCancel: (PointerCancelEvent event) {},
              child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                  width: double.infinity,
                  height: 500,
                  child: CustomPaint(
                    painter: _SignaturePainter(widget.controller),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignatureController extends ValueNotifier<List<Point>> {
  List<Point> get points => value;

  SignatureController(
    List<Point> points,
  ) : super(points ?? <Point>[]);

  /// 开始绘制事件回调
  VoidCallback? onDrawStart;

  /// 手势移动绘制
  VoidCallback? onDrawMove;

  /// 手势绘制结束
  VoidCallback? onDrawEnd;

  /// 手势取消 ,区别与结束： 取消是要撤销本次手势
  VoidCallback? onDrawCancel;

  ///
  void addPoint(Point point){

  }

}

class _SignaturePainter extends CustomPainter {
  SignatureController controller;

  //
  _SignaturePainter(this.controller);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint
      ..strokeWidth = 1.0
      ..color = Colors.black87
      ..isAntiAlias = true;

    int len = points.length;
    for (int i = 0; i < len; i++) {
      //  canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class Point {
  Offset offset;

  double pressure;

  PointType type;

  Point(this.offset, this.pressure, this.type);
}

enum PointType {
  //点
  tap,

  // 线 、笔画
  move
}
