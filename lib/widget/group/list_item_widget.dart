import 'package:flutter/material.dart';

typedef ItemTapCallback = void Function();

class TextNext extends StatelessWidget {

  double paddingLeft = 16.0;
  double paddingRight = 16.0;

  String title;
  Widget suffix;

  ItemTapCallback? callback;

  TextNext(
      {Key? key,
      paddingLeft = 16.0,
      paddingRight = 16.0,
      required this.title,
      required this.suffix,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback?.call();
      },
      child: Container(
        color: Colors.white,
        height: 50,
        padding: EdgeInsets.only(left: paddingLeft, right: paddingRight),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                child: Text(
              title,
              style: const TextStyle(fontSize: 16.0),
            )),
            suffix,
          ],
        ),
      ),
    );
  }
}

class TextNextIcon extends TextNext {
  TextNextIcon(
      {Key? key,
      double paddingLeft = 16.0,
      double paddingRight = 16.0,
      required title,
      ItemTapCallback? callback})
      : super(
          key: key,
          paddingLeft: paddingLeft,
          paddingRight: paddingRight,
          title: title,
          suffix: Icon(Icons.keyboard_arrow_right, color: Colors.grey[400]),
          callback: callback,
        );
}

class PrefixTextSuffixItem extends StatelessWidget {
  double paddingLeft = 16.0;
  double paddingRight = 16.0;

  Widget prefix;
  String title;
  ItemTapCallback? callback;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  Widget suffix;

  PrefixTextSuffixItem({
    super.key,
    required this.prefix,
    required this.title,
    required this.suffix,
    this.callback,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    padding ??= const EdgeInsets.symmetric(horizontal: 16.0);
    return GestureDetector(
      onTap: () {
        callback?.call();
      },
      child: Container(
        color: Colors.white,
        height: 50,
        padding: padding,
        margin: margin,
        child: Row(
          children: [
            prefix,
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              title,
              style: const TextStyle(fontSize: 16.0),
            )),
            suffix,
            //
          ],
        ),
      ),
    );
  }
}

class IconTextNextItem extends PrefixTextSuffixItem {
  IconTextNextItem(
      {required IconData icon,
      Color iconColor = Colors.grey,
      double? iconSize,
      required String title,
      EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? margin,
      ItemTapCallback? callback})
      : super(
            prefix: Icon(icon, color: iconColor, size: iconSize,),
            title: title,
            suffix: Icon(Icons.keyboard_arrow_right, color: Colors.grey[400]),
            padding: padding,
            margin: margin,
            callback: callback);
}

class TextTitleSuffixItem extends StatelessWidget {
  double paddingLeft = 16.0;
  double paddingRight = 16.0;

  Widget prefix;
  String title;
  String subTitle;
  ItemTapCallback? callback;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  Widget suffix;

  TextTitleSuffixItem({
    super.key,
    required this.prefix,
    required this.title,
    required this.subTitle,
    required this.suffix,
    this.callback,
    this.padding,
    this.margin,

  });

  @override
  Widget build(BuildContext context) {
    padding ??= const EdgeInsets.symmetric(horizontal: 16.0);
    return GestureDetector(
      onTap: () {
        callback?.call();
      },
      child: Container(
        color: Colors.white,
        height: 55,
        padding: padding,
        margin: margin,
        child: Row(
          children: [
            prefix,
            const SizedBox(
              width: 10,
            ),
            Column(children: [
              Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 16.0),
                  )),
              Expanded(
                  child: Text(
                    subTitle,
                    style: const TextStyle(fontSize: 14.0),
                  )),
            ],),
            suffix,
            //
          ],
        ),
      ),
    );
  }
}
