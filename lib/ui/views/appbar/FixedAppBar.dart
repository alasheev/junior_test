import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junior_test/tools/MyColors.dart';
import 'package:junior_test/tools/MyDimens.dart';
import 'package:junior_test/ui/views/appbar/flexible/SliverAppBarDelegate.dart';

class FixedAppBar extends StatelessWidget {
  String _title;
  Widget _body;
  int _tabCount = 0;
  Widget _tabs;
  double collapsedHeight = 50.0;
  List<Widget> _actions;
  Widget _customAppbar;

  FixedAppBar(this._title, this._body);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _body,
    );
  }

  Widget _getAppBar() {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: MyColors.appbar_text, //change your color here
      ),
      actions: _actions,
      backgroundColor: MyColors.appbar_color,
      title: (_customAppbar == null) ? _getAppBarText(_title) : _customAppbar,
    );
  }

  Widget _getTabs() {
    return SliverPersistentHeader(
      delegate: SliverAppBarDelegate(_tabs),
      pinned: true,
    );
  }

  Widget _getAppBarText(String title) {
    return Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "YesEva",
          color: MyColors.appbar_text,
          fontSize: MyDimens.subtitleBig,
        ));
  }
}
