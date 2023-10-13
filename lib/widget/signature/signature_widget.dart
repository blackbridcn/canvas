import 'package:flutter/material.dart';

///
/// @File :signature_widget
/// @Class :SignatureWidgetWidget
/// @Author :yuzzha
/// @Date :2023/10/12 17:48
/// @TODO :
///
class SignatureWidget extends StatefulWidget {
  const SignatureWidget({Key? key}) : super(key: key);

  @override
  _SignatureState createState() => _SignatureState();
}

class _SignatureState extends State<SignatureWidget> {
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
              width: double.infinity,
              height: 500,
              child: CustomPaint(
              //  painter: ,
              ),
            ),
        ],
      ),
    );
  }
}



class SignaturePainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }


}