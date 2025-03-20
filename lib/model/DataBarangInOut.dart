class DataBarangInOut {
  DataBarangInOut({
      String? namaBarang, 
      num? id, 
      num? idBarang, 
      num? jumlah, 
      String? catatan,}){
    _namaBarang = namaBarang;
    _id = id;
    _idBarang = idBarang;
    _jumlah = jumlah;
    _catatan = catatan;
}

  DataBarangInOut.fromJson(dynamic json) {
    _namaBarang = json['nama_barang'];
    _id = json['id'];
    _idBarang = json['id_barang'];
    _jumlah = json['jumlah'];
    _catatan = json['catatan'];
  }
  String? _namaBarang;
  num? _id;
  num? _idBarang;
  num? _jumlah;
  String? _catatan;

  String? get namaBarang => _namaBarang;
  num? get id => _id;
  num? get idBarang => _idBarang;
  num? get jumlah => _jumlah;
  String? get catatan => _catatan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nama_barang'] = _namaBarang;
    map['id'] = _id;
    map['id_barang'] = _idBarang;
    map['jumlah'] = _jumlah;
    map['catatan'] = _catatan;
    return map;
  }

}