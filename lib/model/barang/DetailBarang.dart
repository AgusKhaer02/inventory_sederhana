import 'package:express_inventory/model/Barang.dart';

class DetailBarang {
  DetailBarang({
      bool? success, 
      String? message, 
      Barang? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  DetailBarang.fromJson(dynamic json) {
    print("LOG INFO : ${json['data']}");
    _success = json['success'];
    _message = json['message'];
    _data = Barang.fromJson(json['data']);

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
    map['data'] = _data;
    return map;
  }

}