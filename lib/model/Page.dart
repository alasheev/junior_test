class Page {
  int _totalPageCount;
  int _requestedPage;
  int _totalItems;
  int _itemsPerPage;

  Page(
      {int totalPageCount,
      int requestedPage,
      int totalItems,
      int itemsPerPage}) {
    this._totalPageCount = totalPageCount;
    this._requestedPage = requestedPage;
    this._totalItems = totalItems;
    this._itemsPerPage = itemsPerPage;
  }

  Page.fromJson(Map<String, dynamic> json) {
    _totalPageCount = json['totalPageCount'];
    _requestedPage = json['requestedPage'];
    _totalItems = json['totalItems'];
    _itemsPerPage = json['itemsPerPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPageCount'] = this._totalPageCount;
    data['requestedPage'] = this._requestedPage;
    data['totalItems'] = this._totalItems;
    data['itemsPerPage'] = this._itemsPerPage;
    return data;
  }

  int get totalPageCount => (_totalPageCount == null ? -1 : _totalPageCount);

  int get requestedPage => (_requestedPage == null ? -1 : _requestedPage);

  int get totalItems => (_totalItems == null ? -1 : _totalItems);

  int get itemsPerPage => (_itemsPerPage == null ? -1 : _itemsPerPage);
}
