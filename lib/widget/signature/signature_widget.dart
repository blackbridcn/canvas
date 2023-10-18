import 'dart:ui';

import 'package:flutter/material.dart';

///
/// @File :signature_widget
/// @Class :SignatureWidgetWidget
/// @Author :yuzzha
/// @Date :2023/10/12 17:48
/// @TODO :
///
class SignatureWidget extends StatefulWidget {
  double? width;
  double? height;
  Color backgroundColor;
  SignatureController controller;

  //support dynamic pressure for width (if has support for it)
  //支持宽度的动态压力（如果有支持）
  // 就是签名时候笔画超出了签名Widget的布局外
  bool dynamicPressureSupported;

  SignatureWidget(
    this.controller, {
    Key? key,
    this.backgroundColor = Colors.grey,
    this.width,
    this.height,
    this.dynamicPressureSupported = false,
  }) : super(key: key);

  @override
  _SignatureState createState() => _SignatureState();
}

class _SignatureState extends State<SignatureWidget> {
  GlobalKey _globalKey = GlobalKey();

  // Helper变量指示用户已经离开画布，这样我们就可以防止用直线链接下一个点。
  //
  bool _isOutsideDrawField = false;

  ///
  /// 活动指针可防止多点触摸绘图,
  /// Active pointer to prevent multitouch drawing
  ///
  /// 触摸事件id，防止同一个事件重复记录、绘制
  ///
  int? activePointerId;

  /// Max width of canvas
  late double maxWidth;

  /// Max height of canvas
  late double maxHeight;

  /// Real widget size
  Size? screenSize;

  @override
  void initState() {
    super.initState();
    maxWidth = widget.width ?? double.infinity;
    maxHeight = widget.height ?? double.infinity;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenSize = MediaQuery.of(context).size;
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
                  // 回调
                  widget.controller.onDrawStart?.call();
                  // 记录绘制路径
                  _addGesturePoint(event, PointType.tap);
                }
              },
              onPointerMove: (PointerMoveEvent event) {
                if (activePointerId == event.pointer) {
                  // 滑动的线
                  _addGesturePoint(event, PointType.move);
                  widget.controller.onDrawMove?.call();
                }
              },
              onPointerUp: (PointerUpEvent event) {
                if (activePointerId == event.pointer) {
                  //
                  _addGesturePoint(event, PointType.tap);
                  //
                  widget.controller.onDrawEnd?.call();
                  //本次手势结束
                  activePointerId = null;
                }
              },
              onPointerCancel: (PointerCancelEvent event) {
                if (activePointerId == event.pointer) {
                  _addGesturePoint(event, PointType.tap);
                  widget.controller.onDrawCancel?.call();
                  //本次手势结束
                  activePointerId = null;
                }
              },
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

  void _addGesturePoint(PointerEvent event, PointType type) {
    Offset offset = event.localPosition;
    //如果使用的小部件没有尺寸，我们将回退到屏幕大小尺寸
    // 如果maxWidth 为null (没有设置)时,取实际宽
    double _maxSafeWidth = maxWidth == double.infinity ? screenSize!.width : maxWidth;
    double _maxSafeHeight = maxHeight == double.infinity ? screenSize!.height : maxHeight;
    if ((screenSize?.width == null || offset.dx > 0 && offset.dx < _maxSafeWidth) &&
        (screenSize?.height == null || offset.dy > 0 && offset.dy < _maxSafeHeight)) {
      //如果用户离开边界并返回,在一个动作中，重新键入为TAP，因为我们不想将其与上一点链接
      PointType pointType = type;
      if (_isOutsideDrawField) {
        pointType = PointType.tap;
      }
      setState(() {
        _isOutsideDrawField = false;
        widget.controller.addPoint(Point(
          offset,
          pointType,
          widget.dynamicPressureSupported ? event.pressure : 1.0,
        ));
      });
    }
    {
      //表示上一个最后点，已经超出的签名Widget布局
      _isOutsideDrawField = true;
    }
  }
}

class SignatureController extends ValueNotifier<List<Point>> {
  SignatureController(
    List<Point> points, {
    this.penColor = Colors.black,
    this.penStrokeWidth = 3.0,
    this.exportBackgroundColor,
    this.exportPenColor,
    this.onDrawStart,
    this.onDrawMove,
    this.onDrawEnd,
  }) : super(points ?? <Point>[]);

  /// 开始绘制事件回调
  VoidCallback? onDrawStart;

  /// 手势移动绘制
  VoidCallback? onDrawMove;

  /// 手势绘制结束
  VoidCallback? onDrawEnd;

  /// 手势取消 ,区别与结束： 取消是要撤销本次手势
  VoidCallback? onDrawCancel;

  Color penColor;
  Color? exportPenColor;
  double penStrokeWidth;
  Color? exportBackgroundColor;

  set points(List<Point> points) {
    value = points;
  }

  void addPoint(Point point) {
    value.add(point);
    notifyListeners();
  }

  bool get isEmpty => value.isEmpty;

  bool get isNotEmpty => value.isNotEmpty;

  void clear() {
    value.clear();
  }
  
}

class _SignaturePainter extends CustomPainter {
  SignatureController controller;

  //
  final Paint _paint;

  _SignaturePainter(this.controller) : _paint = Paint() {
    _paint
      ..color = controller.penColor
      ..strokeWidth = controller.penStrokeWidth
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    List<Point> points = controller.points;
    int len = points.length;
    for (int i = 0; i < len - 1; i++) {
      if (points[i + 1].type == PointType.move) {
        canvas.drawLine(points[i].offset, points[i + 1].offset, _paint);
      } else {
        canvas.drawCircle(points[i].offset, controller.penStrokeWidth / 2, _paint);
      }
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

  Point(this.offset, this.type, this.pressure);
}

enum PointType {
  //点
  tap,

  // 线 、笔画
  move
}
