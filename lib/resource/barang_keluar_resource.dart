import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:express_inventory/model/DataBarangInOut.dart';
import 'package:express_inventory/model/barang_keluar/BarangKeluar.dart';
import 'package:express_inventory/model/barang_keluar/DeleteBarangKeluar.dart';
import 'package:express_inventory/resource/remote_resource.dart';
import 'package:http/http.dart' as http;

class BarangKeluarResource extends RemoteResource{
  Future<Either<String, List<DataBarangInOut>>> fetchBarangKeluar() async {
    try {
      final reponse = await http.get(Uri.parse('$baseUrl/barang-keluar'));

      if (reponse.statusCode != 200) {
        return Left('Failed to fetch post');
      }
      final barangKeluar = BarangKeluar.fromJson(jsonDecode(reponse.body));
      return Right(barangKeluar.data ?? []);
    } catch (e) {
      return Left("repository : $e");
    }
  }

  Future<Either<String, String>> createBarangKeluar(
      String idBarang,
      String jumlah,
      ) async {
    try {
      final response = await http.post(
          Uri.parse('$baseUrl/barang-keluar'),
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

  Future<Either<String, String>> deleteBarangKeluar(int id) async {
    try {
      final reponse = await http.delete(Uri.parse('$baseUrl/barang-keluar/$id'));
      if (reponse.statusCode != 200) {
        return Left('Failed to delete post');
      }
      final result = DeleteBarangKeluar.fromJson(jsonDecode(reponse.body));
      return Right(result.message ?? '');
    } catch (e) {
      return Left(e.toString());
    }
  }
}