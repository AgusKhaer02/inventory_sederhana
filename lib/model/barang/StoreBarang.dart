import '../Barang.dart';

class StoreBarang {
  StoreBarang({
      bool? success, 
      String? message, 
      Barang? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  StoreBarang.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? Barang.fromJson(json['data']) : null;
  }
  bool? _success;
  String? _message;
  Barang? _data;

  bool? get success => _success;
  String? get message => _message;
  Barang? get data => _data;

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