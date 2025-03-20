import 'package:bloc/bloc.dart';
import 'package:express_inventory/model/DataBarangInOut.dart';
import 'package:express_inventory/model/barang_masuk/BarangMasuk.dart';
import 'package:express_inventory/resource/barang_keluar_resource.dart';
import 'package:express_inventory/resource/barang_masuk_resource.dart';
import 'package:meta/meta.dart';

part 'barang_masuk_state.dart';

class BarangMasukCubit extends Cubit<BarangMasukState> {
  BarangMasukCubit() : super(BarangMasukInitial());

  Future fetchBarang() async {
    emit(BarangMasukLoading());
    try {
      final result = await BarangMasukResource().fetchBarangMasuk();
      result.fold(
        (error) => emit(BarangMasukError(message: error)),
        (barang) => emit(BarangMasukLoaded(barang: barang)),
      );
    } catch (e) {
      emit(BarangMasukError(message: e.toString()));
    }
  }

  Future createBarang({required String idBarang, required String jumlah}) async {
    emit(BarangMasukLoading());
    try {
      final result = await BarangMasukResource().createBarangMasuk(
        idBarang,
        jumlah,
      );
      result.fold(
        (error) => emit(BarangMasukError(message: error)),
        (response) => emit(BarangMasukCreated(message: response)),
      );
    } catch (e) {
      emit(BarangMasukError(message: e.toString()));
    }
  }

  Future deleteBarang(int id) async {
    emit(BarangMasukLoading());
    try {
      final result = await BarangMasukResource().deleteBarangMasuk(id);
      result.fold(
        (error) => emit(BarangMasukError(message: error)),
        (response) => emit(BarangMasukDeleted(message: response)),
      );
    } catch (e) {
      emit(BarangMasukError(message: e.toString()));
    }
  }
}
