import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarTitleFading extends StatefulWidget {
  final Widget child;

  const AppBarTitleFading({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _AppBarTitleFading createState() {
    return new _AppBarTitleFading();
  }
}

class _AppBarTitleFading extends State<AppBarTitleFading> {
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
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: widget.child,
    );
  }
}
