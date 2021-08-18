import 'package:junior_test/model/actions/Promo.dart';

class Home {
  Promos _promo;

  Home({Promos promo}) {
    this._promo = promo;
  }

  Home.fromJson(Map<String, dynamic> json) {
    _promo = json['promo'] != null ? new Promos.fromJson(json['promo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this._promo != null) {
      data['promo'] = this._promo.toJson();
    }
    return data;
  }

  Promos get promo => (_promo == null ? Promos() : _promo);
}
