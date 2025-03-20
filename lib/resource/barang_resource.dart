import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:express_inventory/model/Barang.dart';
import 'package:express_inventory/model/barang/DeleteBarang.dart';
import 'package:express_inventory/model/barang/DetailBarang.dart';
import 'package:express_inventory/model/barang/MasterBarang.dart';
import 'package:express_inventory/resource/remote_resource.dart';
import 'package:http/http.dart' as http;

class BarangResource extends RemoteResource{
  Future<Either<String, List<Barang>>> fetchBarang() async {
    try {
      await Future.delayed(Duration(seconds: 5));
      final reponse = await http.get(Uri.parse('$baseUrl/barang'));

      if (reponse.statusCode != 200) {
        return Left('Failed to fetch post');
      }
      final post = MasterBarang.fromJson(jsonDecode(reponse.body));
      return Right(post.data ?? []);
    } catch (e) {
      return Left("repository : $e");
    }
  }

  Future<Either<String, String>> createBarang(
      File? gambar,
      String namaBarang,
      String keterangan,
      ) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/barang'),
      );
      request.fields['nama_barang'] = namaBarang;
      request.fields['keterangan'] = keterangan;
      if (gambar != null) {
        request.files.add(
          await http.MultipartFile.fromPath('gambar', gambar.path),
        );
      }
      final req = await request.send();
      final response = await http.Response.fromStream(req);
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

  Future<Either<String, String>> updateBarang(
      int id,
      String namaBarang,
      String keterangan,
      File? gambar,
      ) async {
    try {
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/barang/$id'),
      );
      request.fields['nama_barang'] = namaBarang;
      request.fields['keterangan'] = keterangan;
      if (gambar != null) {
        request.files.add(
          await http.MultipartFile.fromPath('gambar', gambar.path),
        );
      }
      final req = await request.send();
      final response = await http.Response.fromStream(req);
      final message = json.decode(response.body)['message'];
      print("ERROR : $message");
      if (response.statusCode >= 200 && response.statusCode < 400) {
        return Right(message);
      } else if (response.statusCode >= 400) {
        return Right(message);
      } else {
        throw Left('Failed to update post');
      }
    } catch (e) {

      print("ERROR : $e");
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> deleteBarang(int id) async {
    try {
      final reponse = await http.delete(Uri.parse('$baseUrl/barang/$id'));
      if (reponse.statusCode != 200) {
        return Left('Failed to delete post');
      }
      final result = DeleteBarang.fromJson(jsonDecode(reponse.body));
      return Right(result.message ?? '');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Barang>> fetchDetailBarang(int id) async {
    try {
      await Future.delayed(Duration(seconds: 5));
      final reponse = await http.get(Uri.parse('$baseUrl/barang/$id'));

      if (reponse.statusCode != 200) {
        return Left('Failed to fetch detail barang');
      }
      final barang = DetailBarang.fromJson(jsonDecode(reponse.body));
      return Right(barang.data!);
    } catch (e) {
      return Left("repository : $e");
    }
  }
}