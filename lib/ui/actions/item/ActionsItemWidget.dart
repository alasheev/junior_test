import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junior_test/blocs/actions/ActionsItemQueryBloc.dart';
import 'package:junior_test/blocs/base/bloc_provider.dart';
import 'package:junior_test/model/RootResponse.dart';
import 'package:junior_test/model/actions/PromoItem.dart';
import 'package:junior_test/resources/api/RootType.dart';
import 'package:junior_test/tools/MyColors.dart';
import 'package:junior_test/tools/MyDimens.dart';
import 'package:junior_test/ui/actions/item/ActionsItemArguments.dart';
import 'package:junior_test/ui/base/NewBasePageState.dart';

class ActionsItemWidget extends StatefulWidget {
  ActionsItemWidget(this.actionId);
  int actionId;

  static String TAG = "ActionsItemWidget";

  @override
  _ActionsItemWidgetState createState() => _ActionsItemWidgetState();
}

class _ActionsItemWidgetState extends NewBasePageState<ActionsItemWidget> {
  ActionsItemQueryBloc bloc;

  _ActionsItemWidgetState() {
    bloc = ActionsItemQueryBloc();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.actionId == -1) {
      final ActionsItemArguments args =
          ModalRoute.of(context).settings.arguments;
      widget.actionId = args.actionId;
    }
    return BlocProvider<ActionsItemQueryBloc>(
        bloc: bloc, child: getBaseQueryStream(bloc.shopItemContentStream));
  }

  @override
  Widget onSuccess(RootTypes event, RootResponse response) {
    var actionInfo = response.serverResponse.body.promo.item;
    return getNetworkAppBar(
        actionInfo.imgFull, _getBody(actionInfo), actionInfo.name,
        brightness: Brightness.light);
  }

  void runOnWidgetInit() {
    bloc.loadActionItemContent(widget.actionId);
  }

  Widget _getBody(PromoItem actionInfo) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            _shopInfo(actionInfo),
            _shopDescription(actionInfo.shop_description),
            SizedBox(height: 20),
            _actionDescriptionFull(actionInfo.description)
          ],
        ));
  }

  Widget _actionDescriptionFull(String text) {
    return Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MyDimens.subtitleBig,
                fontWeight: FontWeight.normal)));
  }

  Widget _shopDescription(String text) {
    return Text(text,
        style: TextStyle(
            color: MyColors.grey,
            fontSize: MyDimens.subtitleSmall,
            fontWeight: FontWeight.normal));
  }

  Widget _shopInfo(PromoItem shopInfo) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
          child: Text(shopInfo.shop,
              style: TextStyle(
                  color: MyColors.black,
                  fontSize: MyDimens.titleNormal,
                  fontWeight: FontWeight.bold))),
      _shopLocationInfo(shopInfo),
    ]);
  }

  Widget _shopLocationInfo(PromoItem shopInfo) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(children: [
        Text(shopInfo.place),
        new IconTheme(
            data: new IconThemeData(color: MyColors.red),
            child: new Icon(Icons.place)),
      ])
    ]);
  }

  Widget _getAppBarText(String text) {
    return Center(
        child: Text(
      text,
      style: TextStyle(
          color: MyColors.white, fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    ));
  }
}
