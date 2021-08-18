import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junior_test/tools/MyColors.dart';
import 'package:junior_test/tools/MyDimens.dart';

class AppBarActionItem extends StatefulWidget {
  Color startColor;
  Color endColor;
  IconData icon;
  String title;

  AppBarActionItem(this.icon,
      {this.startColor = MyColors.black, this.endColor = MyColors.white});

  @override
  _AppBarActionItemState createState() => _AppBarActionItemState();
}

class _AppBarActionItemState extends State<AppBarActionItem> {
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
    return _getAppBarIcon();
  }

  Widget _getAppBarText() {
    return Text(widget.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _visible ? widget.startColor : widget.endColor,
          fontSize: MyDimens.subtitleBig,
        ));
  }

  Widget _getAppBarIcon() {
    return Container(
        margin: EdgeInsets.only(right: 10, top: 8),
        child: Center(
            child: Icon(widget.icon,
                size: MyDimens.titleSmall,
                color: _visible ? widget.startColor : widget.endColor)));
  }
}
