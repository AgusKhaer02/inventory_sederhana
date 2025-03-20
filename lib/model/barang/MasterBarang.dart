import '../Barang.dart';

class MasterBarang {
  MasterBarang({
      bool? success, 
      String? message, 
      List<Barang>? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  MasterBarang.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Barang.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Barang>? _data;

  bool? get success => _success;
  String? get message => _message;
  List<Barang>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}