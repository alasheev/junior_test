class PromoItem {
  int _id;
  String _shop;
  int _shop_id;
  String _name;
  String _description;
  String _imgFull;
  String _imgThumb;
  String _maplink;
  String _place;
  String _shop_description;

  PromoItem({
    int id,
    String shop,
    int shop_id,
    String name,
    String description,
    String imgFull,
    String imgThumb,
    String mapLink,
    String place,
    String shop_description
  }) {
    this._id = id;
    this._shop = shop;
    this._shop_id = shop_id;
    this._name = name;
    this._description = description;
    this._imgFull = imgFull;
    this._imgThumb = imgThumb;
    this._maplink = mapLink;
    this._shop_description = shop_description;
  }

  PromoItem.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _shop = json['shop'];
    _shop_id = json['shop_id'];
    _name = json['name'];
    _description = json['description'];
    _imgFull = json['img_full'];
    _imgThumb = json['img_thumb'];
    _maplink = json['maplink'];
    _place = json['place'];
    _shop_description = json['shop_description'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['shop'] = this._shop;
    data['shop_id'] = this._shop_id;
    data['name'] = this._name;
    data['description'] = this._description;
    data['img_full'] = this._imgFull;
    data['maplink'] = this._maplink;
    data['place'] = this._place;
    data['shop_description'] = this._shop_description;

    return data;
  }

  int get id => (_id == null ? -1 : _id);

  String get shop => (_shop == null ? "null" : _shop);

  int get shop_id => (_shop_id == null ? -1 : _shop_id);

  String get name => (_name == null ? "null" : _name);

  String get description => (_description == null ? "null" : _description);

  String get imgFull => (_imgFull == null ? "null" : _imgFull);

  String get imgThumb => (_imgThumb == null ? "null" : _imgThumb);

  String get maplink => (_maplink == null ? "null": _maplink);

  String get place => (_place == null ? "null": _place);

  String get shop_description => (_shop_description == null ? "null" : _shop_description);

}
