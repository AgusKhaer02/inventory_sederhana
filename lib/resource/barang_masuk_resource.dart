import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:express_inventory/model/DataBarangInOut.dart';
import 'package:express_inventory/model/barang_masuk/BarangMasuk.dart';
import 'package:express_inventory/model/barang_masuk/DeleteBarangMasuk.dart';
import 'package:express_inventory/resource/remote_resource.dart';
import 'package:http/http.dart' as http;

class BarangMasukResource extends RemoteResource{
  Future<Either<String, List<DataBarangInOut>>> fetchBarangMasuk() async {
    try {
      final reponse = await http.get(Uri.parse('$baseUrl/barang-masuk'));

      if (reponse.statusCode != 200) {
        return Left('Failed to fetch post');
      }
      final barangMasuk = BarangMasuk.fromJson(jsonDecode(reponse.body));
      return Right(barangMasuk.data ?? []);
    } catch (e) {
      return Left("repository : $e");
    }
  }

  Future<Either<String, String>> createBarangMasuk(
      String idBarang,
      String jumlah,
      ) async {
    try {
      final response = await http.post(
          Uri.parse('$baseUrl/barang-masuk'),
          body: {
            "id_barang" : idBarang,
            "jumlah" : jumlah
          }
      );
      if (response.statusCode == 201) {
        final message = json.decode(response.body)['message'];
        return Right(message);
      } else {
        throw Left('Failed to create post');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> deleteBarangMasuk(int id) async {
    try {
      final reponse = await http.delete(Uri.parse('$baseUrl/barang-masuk/$id'));
      if (reponse.statusCode != 200) {
        return Left('Failed to delete post');
      }
      final result = DeleteBarangMasuk.fromJson(jsonDecode(reponse.body));
      return Right(result.message ?? '');
    } catch (e) {
      return Left(e.toString());
    }
  }
}