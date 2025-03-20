class Barang {
  Barang({
      num? id, 
      String? namaBarang, 
      String? keterangan, 
      String? gambar, 
      String? createdAt, 
      String? updatedAt, 
      num? stok,}){
    _id = id;
    _namaBarang = namaBarang;
    _keterangan = keterangan;
    _gambar = gambar;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _stok = stok;
}

  Barang.fromJson(dynamic json) {
    _id = json['id'];
    _namaBarang = json['nama_barang'];
    _keterangan = json['keterangan'];
    _gambar = json['gambar'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _stok = json['stok'] ?? 0;
  }
  num? _id;
  String? _namaBarang;
  String? _keterangan;
  String? _gambar;
  String? _createdAt;
  String? _updatedAt;
  num? _stok;

  num? get id => _id;
  String? get namaBarang => _namaBarang;
  String? get keterangan => _keterangan;
  String? get gambar => _gambar;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get stok => _stok;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nama_barang'] = _namaBarang;
    map['keterangan'] = _keterangan;
    map['gambar'] = _gambar;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['stok'] = _stok;
    return map;
  }

}