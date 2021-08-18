// ignore: file_names
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:junior_test/blocs/actions/ActionsItemQueryBloc.dart';
import 'package:junior_test/blocs/actions/ActionsQueryBloc.dart';
import 'package:junior_test/blocs/base/bloc_provider.dart';
import 'package:junior_test/resources/api/RootType.dart';
import 'package:junior_test/model/RootResponse.dart';
import 'package:junior_test/tools/MyColors.dart';
import 'package:junior_test/tools/Tools.dart';
import 'package:junior_test/ui/base/NewBasePageState.dart';
import 'package:junior_test/ui/views/appbar/flexible/FlexAppBar.dart';

import 'item/ActionsItemWidget.dart';

class ActionsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends NewBasePageState<ActionsWidget> {
  String appBarImage = '';

  List items = [];
  ActionsQueryBloc bloc;
  int page = 0;
  int count = 4;

  var scrollController = ScrollController();

  _ActionsWidgetState() {
    bloc = ActionsQueryBloc();
  }

  @override
  void initState() {
    super.initState();

    bloc.loadActionsContent(page++, count);

    // bloc.loadActionsContent(page, count);

    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   bloc.loadActionsContent(page, count);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RootResponse>(
      stream: bloc.shopItemsStream,
      builder: (context, AsyncSnapshot<RootResponse> snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        }
        if (snapshot.data.currentEvent == RootTypes.EVENT_REFRESH_WIDGET) {
          return onSuccess(snapshot.data.currentEvent, snapshot.data);
        }

        if (snapshot.data.serverResponse.code.code == 200) {
          return onSuccess(snapshot.data.currentEvent, snapshot.data);
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget onSuccess(RootTypes event, RootResponse response) {
    var actionInfo = response.serverResponse.body.promo.list;

    if (appBarImage == '') {
      appBarImage = actionInfo.first.imgFull;
    }

    items.addAll(actionInfo.map((e) => Item(e.id, e.shop, e.imgFull, e.name)));

    if (items.length > 0 && items.length % 10 == 0){
      page = 0;
    }

    return getNetworkAppBar(appBarImage, ItemTiles(), 'Акции');
  }

  Widget ItemTiles() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bloc.loadActionsContent(page++, count);
      }
    });
    return StaggeredGridView.countBuilder(
      controller: scrollController,
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActionsItemWidget(items[index].id),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(Tools.getImagePath(items[index].imgFull)),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    items[index].name,
                    style:
                        TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  items[index].shop,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    );
  }
}

class Item {
  int id;
  String shop;
  String imgFull;
  String name;
  Item(this.id, this.shop, this.imgFull, this.name);
}
