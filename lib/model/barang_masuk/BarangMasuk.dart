import '../DataBarangInOut.dart';

class BarangMasuk {
  BarangMasuk({
      bool? success, 
      String? message, 
      List<DataBarangInOut>? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  BarangMasuk.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DataBarangInOut.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<DataBarangInOut>? _data;

  bool? get success => _success;
  String? get message => _message;
  List<DataBarangInOut>? get data => _data;

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