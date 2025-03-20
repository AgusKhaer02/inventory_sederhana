import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:express_inventory/model/DataBarangInOut.dart';
import 'package:express_inventory/model/barang_keluar/BarangKeluar.dart';
import 'package:express_inventory/resource/barang_keluar_resource.dart';
import 'package:meta/meta.dart';

part 'barang_keluar_state.dart';

class BarangKeluarCubit extends Cubit<BarangKeluarState> {
  BarangKeluarCubit() : super(BarangKeluarInitial());

  Future fetchBarang() async {
    emit(BarangKeluarLoading());
    try {
      final result = await BarangKeluarResource().fetchBarangKeluar();
      result.fold(
        (error) => emit(BarangKeluarError(message: error)),
        (barang) => emit(BarangKeluarLoaded(barang: barang)),
      );
    } catch (e) {
      emit(BarangKeluarError(message: e.toString()));
    }
  }

  Future createBarang({required String idBarang, required String jumlah}) async {
    emit(BarangKeluarLoading());
    try {
      final result = await BarangKeluarResource().createBarangKeluar(
        idBarang,
        jumlah,
      );
      result.fold(
        (error) => emit(BarangKeluarError(message: error)),
        (response) => emit(BarangKeluarCreated(message: response)),
      );
    } catch (e) {
      emit(BarangKeluarError(message: e.toString()));
    }
  }

  Future deleteBarang(int id) async {
    emit(BarangKeluarLoading());
    try {
      final result = await BarangKeluarResource().deleteBarangKeluar(id);
      result.fold(
        (error) => emit(BarangKeluarError(message: error)),
        (response) => emit(BarangKeluarDeleted(message: response)),
      );
    } catch (e) {
      emit(BarangKeluarError(message: e.toString()));
    }
  }
}
