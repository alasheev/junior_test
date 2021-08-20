import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:junior_test/blocs/actions/ActionsQueryBloc.dart';
import 'package:junior_test/blocs/base/bloc_provider.dart';
import 'package:junior_test/model/actions/PromoItem.dart';
import 'package:junior_test/resources/api/RootType.dart';
import 'package:junior_test/model/RootResponse.dart';
import 'package:junior_test/tools/Tools.dart';
import 'package:junior_test/ui/base/NewBasePageState.dart';

import 'item/ActionsItemWidget.dart';

class ActionsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends NewBasePageState<ActionsWidget> {
  List<PromoItem> items = [];

  String appBarImage = '';

  ActionsQueryBloc bloc;
  int page = 0;
  int count = 4;

  var scrollController = ScrollController();

  _ActionsWidgetState() {
    bloc = ActionsQueryBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActionsQueryBloc>(
        bloc: bloc, child: getBaseQueryStream(bloc.shopItemsStream));
  }

  Widget onSuccess(RootTypes event, RootResponse response) {
    items.addAll(response.serverResponse.body.promo.list);

    if (appBarImage == '') {
      appBarImage = items.first.imgFull;
    }

    if (items.length > 0 && items.length % 10 == 0) {
      page = 0;
    }

    return getNetworkAppBar(appBarImage, ItemTiles(), 'Акции');
  }

  Widget ItemTiles() {
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
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
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
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
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
      staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 4 : 2),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    );
  }

  void runOnWidgetInit() {
    bloc.loadActionsContent(page++, count);

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bloc.loadActionsContent(page++, count);
      }
    });
  }
}
