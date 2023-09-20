import 'package:flutter/material.dart';

import 'cavas/blur.dart';
import 'cavas/circle.dart';
import 'cavas/color.dart';
import 'cavas/image.dart';
import 'cavas/oval.dart';
import 'cavas/paint.dart';
import 'cavas/path.dart';
import 'cavas/point.dart';
import 'cavas/rect.dart';
import 'cavas/shadow.dart';
import 'cavas/text.dart';
import 'utils/global_utils.dart';
import 'utils/image_utils.dart';
import 'utils/route_utils.dart';
import 'widget/list_item_widget.dart';
import 'dart:ui' as ui;

///
/// 重点参照
///https://juejin.cn/column/7023270514814631950
///
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: GlobalUtils.navigatorKey,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    loadImageTask();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Canvas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconTextNextItem(
                icon: Icons.account_tree_outlined,
                iconColor: Colors.green,
                title: "PointWidget",
                callback: () {
                  navPage(PointWidget());
                }),
            _buildDivider(),
            IconTextNextItem(
                icon: Icons.ac_unit,
                iconColor: Colors.purple,
                title: "CircleWidget",
                callback: () {
                  navPage(CircleWidget());
                }),
            _buildDivider(),
            IconTextNextItem(
                icon: Icons.add,
                iconColor: Colors.yellow,
                title: "OvalWidget",
                callback: () {
                  navPage(OvalWidget());
                }),
            _buildDivider(),

            IconTextNextItem(
                icon: Icons.account_balance_outlined,
                iconColor: Colors.blue,
                title: "RectWidget",
                callback: () {
                  navPage(RectWidget());
                }),
            _buildDivider(),
            IconTextNextItem(
                icon: Icons.image_aspect_ratio_outlined,
                iconColor: Colors.greenAccent,
                title: "ImageWidget",
                callback: () {
                  navPage(ImageWidget(image));
                }),
            _buildDivider(),
            IconTextNextItem(
                icon: Icons.camera_outlined,
                iconColor: Colors.blue,
                title: "ColorWidget",
                callback: () {
                  navPage(ColorWidget());
                }),
            _buildDivider(),
            IconTextNextItem(
                icon: Icons.satellite_alt_outlined,
                iconColor: Colors.green,
                title: "ShadowWidget",
                callback: () {
                  navPage(ShadowWidget());
                }),
            _buildDivider(),
            IconTextNextItem(
                icon: Icons.swipe,
                iconColor: Colors.purple,
                title: "PaintWidget",
                callback: () {
                  navPage(PaintWidget(launcher));
                }),
            _buildDivider(),
            IconTextNextItem(
                icon: Icons.swipe,
                iconColor: Colors.purple,
                title: "BlurWidget",
                callback: () {
                  navPage(BlurWidget(launcher));
                }),
            _buildDivider(),
            IconTextNextItem(
                icon: Icons.swipe,
                iconColor: Colors.purple,
                title: "PathWidget",
                callback: () {
                  navPage(PathWidget());
                }),
            _buildDivider(),
            IconTextNextItem(
                icon: Icons.text_fields_outlined,
                iconColor: Colors.teal,
                title: "TestWidget",
                callback: () {
                  navPage(TestWidget());
                }),
            _buildDivider(),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Widget _buildDivider() {
    return const Divider(
      height: 1.0,
    );
  }

  void navPage(Widget targetPage) {
    NavigatorUtils.push(targetPage);
    //Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  late ui.Image image;
  late ui.Image launcher;

  Future<void> loadImageTask() async {
    AssetImage images = const AssetImage('images/chair-alpha.png');
    image = await ImageUtils.loadImageByProvider(images);

    AssetImage images1 = const AssetImage('images/ic_launcher.png');
    launcher = await ImageUtils.loadImageByProvider(images1);
  }

}
