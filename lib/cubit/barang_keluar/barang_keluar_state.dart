part of 'barang_keluar_cubit.dart';

@immutable
sealed class BarangKeluarState {}

final class BarangKeluarInitial extends BarangKeluarState {}

final class BarangKeluarLoading extends BarangKeluarState {}

final class BarangKeluarLoaded extends BarangKeluarState {
  final List<DataBarangInOut> barang;
  BarangKeluarLoaded({required this.barang});
}

final class BarangKeluarCreated extends BarangKeluarState {
  final String message;
  BarangKeluarCreated({required this.message});
}

final class BarangKeluarDeleted extends BarangKeluarState {
  final String message;
  BarangKeluarDeleted({required this.message});
}

final class BarangKeluarUpdated extends BarangKeluarState {
  final String message;
  BarangKeluarUpdated({required this.message});
}

final class BarangKeluarError extends BarangKeluarState {
  final String message;
  BarangKeluarError({required this.message});
}