import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junior_test/tools/MyColors.dart';
import 'package:junior_test/tools/MyDimens.dart';
import 'package:junior_test/ui/views/appbar/flexible/AppBarTitleFading.dart';
import 'package:junior_test/ui/views/appbar/flexible/SliverAppBarDelegate.dart';

class FlexAppBar extends StatelessWidget {
  String _title;
  Widget _appBarBackground;
  Widget _body;
  bool _isCollapsed;
  int _tabCount = 0;
  TabBar _tabBar;

  double expandedHeight = 200.0;
  double collapsedHeight = 55.0;
  double topMargin = 0;
  List<Widget> _actions;

  Brightness _brightness;

  FlexAppBar(this._title, this._appBarBackground, this._body, this._isCollapsed,
      {List<Widget> actions, Brightness brightness = Brightness.dark}) {
    _actions = actions;
    _brightness = brightness;
  }

  FlexAppBar.withTabs(this._title, this._appBarBackground, this._tabCount,
      this._tabBar, this._body, this._isCollapsed,
      {List<Widget> actions, Brightness brightness = Brightness.dark}) {
    _actions = actions;
    _brightness = brightness;
  }

  FlexAppBar.simple(this._title, this._body,
      {List<Widget> actions, Brightness brightness = Brightness.dark}) {
    expandedHeight = 55;
    _isCollapsed = false;
    _actions = actions;
    _brightness = brightness;
  }

  ScrollController getScrollController() {
    if (_isCollapsed) {
      return new ScrollController(
          initialScrollOffset: expandedHeight - collapsedHeight);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return (_tabCount == 0)
        ? Scaffold(body: _getBaseAppBar(context))
        : _getBaseAppBarWithTabs(context);
  }

  Widget _getBaseAppBar(BuildContext context) {
    return NestedScrollView(
        controller: getScrollController(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [_getAppBar(context)];
        },
        body: _body);
  }

  Widget _getBaseAppBarWithTabs(BuildContext context) {
    return DefaultTabController(
      length: _tabCount,
      child: NestedScrollView(
          controller: getScrollController(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              _getAppBar(context),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(_tabBar),
                pinned: true,
              )
            ];
          },
          body: Scaffold(body: SafeArea(top: false, child: _body))),
    );
  }

  Widget _getAppBar(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor: MyColors.appbar_color,
      brightness: _brightness,
      expandedHeight: expandedHeight,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: AppBarTitleFading(child: _getAppBarText(_title)),
          background: _appBarBackground),
      actions: _actions,
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
