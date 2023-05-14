import 'dart:convert';

class KategoriBarangModel {
  var id;
  final String nama;
  KategoriBarangModel({
    this.id,
    required this.nama,
  });

  KategoriBarangModel copyWith({
    int? id,
    String? nama,
  }) {
    return KategoriBarangModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_kategori_barang': id,
      'nama_kategori_barang': nama,
    };
  }

  factory KategoriBarangModel.fromMap(Map<String, dynamic> map) {
    return KategoriBarangModel(
      id: map['id_kategori_barang']?.toInt() ?? 0,
      nama: map['nama_kategori_barang'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory KategoriBarangModel.fromJson(String source) =>
      KategoriBarangModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'KategoriBarangModel(id: $id, nama: $nama)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KategoriBarangModel && other.id == id && other.nama == nama;
  }

  @override
  int get hashCode => id.hashCode ^ nama.hashCode;
}
