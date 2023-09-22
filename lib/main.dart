import 'package:flutter/material.dart';
import 'package:flutter_pinned_shortcut/flutter_pinned_shortcut.dart';

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
import 'widget/group/list_item_widget.dart';
import 'dart:ui' as ui;

import 'widget/single/heart_path.dart';

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
      //home: QuickPage(),
      //home: PinnedShortcutWidget(),
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

            IconTextNextItem(
                icon: Icons.text_fields_outlined,
                iconColor: Colors.teal,
                title: "HeartPathWidget",
                callback: () {
                  navPage(HeartPathWidget());
                }),
            _buildDivider(),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _buildBottomSheet();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _buildBottomSheet(){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          width: double.infinity,
          height: 300,
          color: Colors.red,
          alignment: Alignment.centerLeft,
          child: Text("showModalBottomSheet", style: TextStyle(color: Colors.white),),
        );
      },
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



class PinnedShortcutWidget extends StatefulWidget {
  const PinnedShortcutWidget({super.key});

  @override
  State<PinnedShortcutWidget> createState() => _PinnedShortcutState();
}

class _PinnedShortcutState extends State<PinnedShortcutWidget> {
  final _flutterPinnedShortcutPlugin = FlutterPinnedShortcut();

  @override
  void initState() {
    super.initState();
    getIncomingAction();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: addPinnedShortcut,
            child: const Text("Add Pinned Shortcut"),
          ),
        ),
      ),
    );
  }

  void addPinnedShortcut() {
    _flutterPinnedShortcutPlugin.createPinnedShortcut(
        id: "1",
        label: "Followers",
        action: "followers",
        iconAssetName: "images/ic_launcher.png"
    );
  }

  void getIncomingAction() {
    _flutterPinnedShortcutPlugin.getLaunchAction((action) {
      print(action);
      switch (action) {
        case "followers":
          NavigatorUtils.push(TestWidget());
        ///navigate to follower screen.
          break;
        case "profile":
          NavigatorUtils.push(TestWidget());
        ///navigate to profile screen.
      }
    });
  }
}
