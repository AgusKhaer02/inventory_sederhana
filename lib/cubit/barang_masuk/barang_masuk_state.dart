part of 'barang_masuk_cubit.dart';

@immutable
sealed class BarangMasukState {}

final class BarangMasukInitial extends BarangMasukState {}

final class BarangMasukLoading extends BarangMasukState {}

final class BarangMasukLoaded extends BarangMasukState {
  final List<DataBarangInOut> barang;
  BarangMasukLoaded({required this.barang});
}

final class BarangMasukCreated extends BarangMasukState {
  final String message;
  BarangMasukCreated({required this.message});
}

final class BarangMasukDeleted extends BarangMasukState {
  final String message;
  BarangMasukDeleted({required this.message});
}

final class BarangMasukUpdated extends BarangMasukState {
  final String message;
  BarangMasukUpdated({required this.message});
}

final class BarangMasukError extends BarangMasukState {
  final String message;
  BarangMasukError({required this.message});
}