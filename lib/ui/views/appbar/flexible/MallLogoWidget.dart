import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MallLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterLogo();
    return FittedBox(
        child: Stack(children: [
          // Image(
          //   image: AssetImage('mall_background.png'),
          //   fit: BoxFit.cover,
          // ),
          // Container(
          //     margin: EdgeInsets.only(left: 24.0, top: 24.0, bottom: 8.0),
          //     child: Image(image: AssetImage('mall_logo_transparent.png')))
        ]),
        fit: BoxFit.cover);
  }
}
