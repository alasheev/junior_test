import 'package:junior_test/model/Page.dart';
import 'package:junior_test/model/actions/PromoItem.dart';

class Promos {
  String _title;

  List<PromoItem> _list;

  Page _page;

  PromoItem _item;

  Promos({String title, List<PromoItem> list, Page page, PromoItem item}) {
    this._title = title;
    this._list = list;
    this._page = page;
    this._item = item;
  }

  List<PromoItem> get list => (_list == null)? List() : _list;

  Page get page => (_page == null)? Page() : _page;

  PromoItem get item => (_item == null)? PromoItem() : _item;

  Promos.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    if (json['list'] != null) {
      _list = new List<PromoItem>();
      json['list'].forEach((v) {
        _list.add(new PromoItem.fromJson(v));
      });
    }
    _page = json['page'] != null ? new Page.fromJson(json['page']) : null;

    _item = json['item'] != null ? new PromoItem.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    if (this._list != null) {
      data['list'] = this._list.map((v) => v.toJson()).toList();
    }
    if (this._page != null) {
      data['page'] = this._page.toJson();
    }
    if (this._item != null) {
      data['item'] = this._item.toJson();
    }
    return data;
  }

  String get title => (_title == null ? "null" : _title);
}
