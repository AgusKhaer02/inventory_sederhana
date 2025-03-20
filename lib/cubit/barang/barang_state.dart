part of 'barang_cubit.dart';

@immutable
sealed class BarangState {}

final class BarangInitial extends BarangState {}

final class BarangLoading extends BarangState {}

final class BarangLoaded extends BarangState {
  final List<Barang> barang;
  BarangLoaded({required this.barang});
}
final class DetailBarangLoaded extends BarangState {
  final Barang barang;
  DetailBarangLoaded({required this.barang});
}

final class BarangCreated extends BarangState {
  final String message;
  BarangCreated({required this.message});
}

final class BarangDeleted extends BarangState {
  final String message;
  BarangDeleted({required this.message});
}

final class BarangUpdated extends BarangState {
  final String message;
  BarangUpdated({required this.message});
}

final class BarangError extends BarangState {
  final String message;
  BarangError({required this.message});
}