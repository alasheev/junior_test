import 'package:junior_test/model/Home.dart';
import 'package:junior_test/model/actions/Promo.dart';
import 'package:junior_test/resources/api/RootType.dart';

class RootResponse {
  ServerResponse _serverResponse;
  RootTypes currentEvent;
  String _options;

  RootResponse({ServerResponse serverResponse}) {
    this._serverResponse = serverResponse;
  }

  void setEventType(RootTypes type) {
    currentEvent = type;
  }

  void setCodeResponseOk() {
    _serverResponse = ServerResponse();
    _serverResponse.setCodeOk();
  }

  RootResponse.fromJson(Map<String, dynamic> json) {
    _serverResponse = json['serverResponse'] != null
        ? new ServerResponse.fromJson(json['serverResponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._serverResponse != null) {
      data['serverResponse'] = this._serverResponse.toJson();
    }
    return data;
  }

  ServerResponse get serverResponse =>
      (_serverResponse == null ? ServerResponse() : _serverResponse);

  set barcodeResult(String info) {
    _options = info;
  }

  String get barcodeResult => (_options == null ? "" : _options);
}

class ServerResponse {
  Code _code;
  Body _body;

  ServerResponse({Code code, Body body}) {
    this._code = code;
    this._body = body;
  }

  ServerResponse.fromJson(Map<String, dynamic> json) {
    _code = json['code'] != null ? new Code.fromJson(json['code']) : null;
    _body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._code != null) {
      data['code'] = this._code.toJson();
    }
    if (this._body != null) {
      data['body'] = this._body.toJson();
    }
    return data;
  }

  Code get code => (_code == null ? Code() : _code);

  Body get body => (_body == null ? Body() : _body);

  void setCodeOk() {
    _code = Code();
    _code.setCustomCode(200);
  }
}

class Code {
  int _code;
  String _message;

  Code({int code, String message}) {
    this._code = code;
    this._message = message;
  }

  Code.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['message'] = this._message;
    return data;
  }

  int get code => (_code == null ? -1 : _code);

  String get message => (_message == null ? "null" : _message);

  void setCustomCode(int code) {
    _code = code;
  }
}

class Body {
  Home _home;
  Promos _promo;

  Body({Home home, Promos promo}) {
    this._home = home;
    this._promo = promo;
  }

  Body.fromJson(Map<String, dynamic> json) {
    _promo = json['promo'] != null ? Promos.fromJson(json['promo']) : null;
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
