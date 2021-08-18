import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:junior_test/model/RootResponse.dart';
import 'package:junior_test/resources/api/RootType.dart';
import 'package:junior_test/tools/MyColors.dart';
import 'package:junior_test/tools/MyDimens.dart';
import 'package:junior_test/tools/Strings.dart';
import 'package:junior_test/tools/Tools.dart';
import 'package:junior_test/ui/views/appbar/FixedAppBar.dart';
import 'package:junior_test/ui/views/appbar/flexible/FlexAppBar.dart';
import 'package:junior_test/ui/views/appbar/flexible/MallLogoWidget.dart';

abstract class NewBasePageState<T extends StatefulWidget> extends State<T> {
  Widget appbar;

  @override
  void initState() {
    super.initState();
    apiFetcher();
  }

  void apiFetcher() {}

  String getAppBarTitle() {
    return Strings.appname;
  }

  String getAppBarImage() {
    return "null";
  }

  Widget getBody(BuildContext context) {
    return Text("base root");
  }

  @override
  Widget build(BuildContext context) {
    return getNetworkAppBar(
        getAppBarImage(), getBody(context), getAppBarTitle());
  }

  bool isCollapsed() {
    return false;
  }

  Widget getNetworkAppBar(String appBarImageLink, Widget body, String title,
      {List<Widget> actions, Brightness brightness = Brightness.dark}) {
    Widget networkBackground = Container(
        color: MyColors.grey_light,
        child: Card(
            margin: EdgeInsets.zero,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            child: CachedNetworkImage(
              imageUrl: Tools.getImagePath(appBarImageLink),
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Image(image: AssetImage('mall_background.png')),
              imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              )),
            )));
    return FlexAppBar(title, networkBackground, body, isCollapsed(),
        actions: actions, brightness: brightness);
  }

  Widget StaticAppBar(String title, Widget body,
      {List<Widget> actions, Brightness brightness = Brightness.dark}) {
    return FlexAppBar(
      title,
      MallLogoWidget(),
      body,
      isCollapsed(),
      actions: actions,
      brightness: brightness,
    );
  }

  StreamBuilder<RootResponse> getBaseQueryStream(Stream stream,
      {bool isShowProgress = true}) {
    return StreamBuilder<RootResponse>(
        stream: stream,
        builder: (context, AsyncSnapshot<RootResponse> snapshot) {
          if (!snapshot.hasData) {
            print(getWidgetName() + " showInit");
            return _showInitWidget();
          }
          if (snapshot.data.currentEvent == RootTypes.EVENT_STOP) {
            print(getWidgetName() + " show blank");
            return showBlankWidget();
          }
          if (snapshot.data.currentEvent == RootTypes.EVENT_REFRESH_WIDGET) {
            print(getWidgetName() + " refresh widget");
            return onSuccess(snapshot.data.currentEvent, snapshot.data);
          }

          if (snapshot.data.currentEvent == RootTypes.EVENT_NETWORK_EXCEPTION) {
            print(getWidgetName() + " onLogicError");
            return onNetworkError(snapshot.data.currentEvent, snapshot.data);
          }
          if (snapshot.data.serverResponse.code.code == 200) {
            print(getWidgetName() + " onSuccess");
            return onSuccess(snapshot.data.currentEvent, snapshot.data);
          }
          if (snapshot.data.serverResponse.code.code == 400) {
            print(getWidgetName() + " onAuthError");
            return onAuthError();
          } else {
            print(getWidgetName() + " onLogicError");
            return onLogicOtherError(snapshot.data.serverResponse.code.code,
                snapshot.data.currentEvent, snapshot.data);
          }
        });
  }

  Widget onSuccess(RootTypes event, RootResponse response);

  Widget showProgress() {
    return Center(child: CircularProgressIndicator());
  }

  Widget onNetworkError(RootTypes event, RootResponse response) {
    return onLogicError(event, response);
  }

  Widget onAuthError() {
    return FixedAppBar(
      Strings.account,
      _getRegisterBody(),
    );
  }

  Widget onLogicError(RootTypes event, RootResponse response) {
    return StaticAppBar(
        Strings.appname,
        InkWell(
            onTap: () {
              runOnWidgetInit();
            },
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Icon(Icons.cloud_off, color: MyColors.blue, size: 100.0),
                  Text(
                    Strings.connection_error,
                    style: TextStyle(
                        fontSize: 35,
                        color: MyColors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ]))));
  }

  Widget showBlankWidget() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _showInitWidget() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      runOnWidgetInit();
    });
    return initWidget();
  }

  Widget initWidget() {
    return StaticAppBar(
        Strings.appname,
        Container(
            child: Center(
          child: CircularProgressIndicator(),
        )));
  }

  void runOnWidgetInit() {}

  String getWidgetName() {
    return "base";
  }

  Widget _getRegisterBody() {
    return Center(
        child: SingleChildScrollView(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getAccountImage(),
        SizedBox(height: 50),
        Text(Strings.log_in_text,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MyDimens.subtitleBig,
                color: MyColors.black)),
        SizedBox(height: 50),
        Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            color: MyColors.black_light,
            child: Container(
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 80, right: 80),
                child: Text(Strings.log_in,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: 1.2,
                        fontSize: MyDimens.titleSmall,
                        color: MyColors.white,
                        fontWeight: FontWeight.bold))))
      ],
    )));
  }

  Widget _getAccountImage() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(margin: EdgeInsets.all(10), child: Text("account"))
    ]);
  }

  Widget onLogicOtherError(int code, RootTypes event, RootResponse response) {
    return onLogicError(event, response);
  }
}
