import '../DataBarangInOut.dart';

class StoreBarangMasuk {
  StoreBarangMasuk({bool? success, String? message, DataBarangInOut? data}) {
    _success = success;
    _message = message;
    _data = data;
  }

  StoreBarangMasuk.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data =
        json['data'] != null ? DataBarangInOut.fromJson(json['data']) : null;
  }

  bool? _success;
  String? _message;
  DataBarangInOut? _data;

  bool? get success => _success;

  String? get message => _message;

  DataBarangInOut? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}
