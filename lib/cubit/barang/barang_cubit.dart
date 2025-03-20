import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:express_inventory/model/Barang.dart';
import 'package:express_inventory/resource/barang_resource.dart';
import 'package:meta/meta.dart';

part 'barang_state.dart';

class BarangCubit extends Cubit<BarangState> {
  BarangCubit() : super(BarangInitial());

  Future fetchBarang() async {
    emit(BarangLoading());
    try {
      final result = await BarangResource().fetchBarang();
      result.fold(
        (error) => emit(BarangError(message: error)),
        (posts) => emit(BarangLoaded(barang: posts)),
      );
    } catch (e) {
      emit(BarangError(message: e.toString()));
    }
  }

  Future detailBarang({required int id}) async {
    emit(BarangLoading());
    try {
      final result = await BarangResource().fetchDetailBarang(id);
      result.fold(
            (error) => emit(BarangError(message: error)),
            (barang) => emit(DetailBarangLoaded(barang: barang)),
      );
    } catch (e) {
      emit(BarangError(message: e.toString()));
    }
  }

  Future createBarang({
    required String namaBarang,
    required String keterangan,
    required File image,
  }) async {
    emit(BarangLoading());
    try {
      final result = await BarangResource().createBarang(
        image,
        namaBarang,
        keterangan,
      );
      result.fold(
        (error) => emit(BarangError(message: error)),
        (response) => emit(BarangCreated(message: response)),
      );
    } catch (e) {
      emit(BarangError(message: e.toString()));
    }
  }

  Future deleteBarang(int id) async {
    emit(BarangLoading());
    try {
      final result = await BarangResource().deleteBarang(id);
      result.fold(
        (error) => emit(BarangError(message: error)),
        (response) => emit(BarangDeleted(message: response)),
      );
    } catch (e) {
      emit(BarangError(message: e.toString()));
    }
  }

  Future updateBarang({
    required int id,
    required String namaBarang,
    required String keterangan,
    required File? image,
  }) async {
    emit(BarangLoading());
    try {
      final result = await BarangResource().updateBarang(
        id,
        namaBarang,
        keterangan,
        image,
      );
      result.fold(
        (error) => emit(BarangError(message: error)),
        (response) => emit(BarangUpdated(message: response)),
      );
    } catch (e) {
      emit(BarangError(message: e.toString()));
    }
  }
}
