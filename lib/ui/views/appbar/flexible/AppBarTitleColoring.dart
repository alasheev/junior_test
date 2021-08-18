import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junior_test/tools/MyDimens.dart';

class AppBarTitleColoring extends StatefulWidget {
  Color startColor;
  Color endColor;
  String title;

  AppBarTitleColoring(this.title, this.startColor, this.endColor);

  @override
  _AppBarTitleColoringState createState() => _AppBarTitleColoringState();
}

class _AppBarTitleColoringState extends State<AppBarTitleColoring> {
  ScrollPosition _position;
  bool _visible;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings =
        context.findAncestorWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getAppBarText();
  }

  Widget _getAppBarText() {
    return Text(widget.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _visible ? widget.startColor : widget.endColor,
          fontSize: MyDimens.subtitleBig,
        ));
  }
}
