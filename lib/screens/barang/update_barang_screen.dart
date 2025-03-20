import 'dart:io';

import 'package:express_inventory/cubit/barang/barang_cubit.dart';
import 'package:express_inventory/model/Barang.dart';
import 'package:express_inventory/screens/barang/components/update_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateBarangScreen extends StatefulWidget {
  const UpdateBarangScreen({super.key});

  @override
  State<UpdateBarangScreen> createState() => _UpdateBarangScreenState();
}

class _UpdateBarangScreenState extends State<UpdateBarangScreen> {
  late BarangCubit barangCubit;
  Map<String, dynamic>? args;

  initFetch() {
    barangCubit = BarangCubit();
  }

  @override
  void initState() {
    initFetch();
    super.initState();
  }
  @override
  void dispose() {
    barangCubit.fetchBarang();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Update Barang',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<BarangCubit, BarangState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          print("the state is triggered");
          if (state is BarangLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DetailBarangLoaded) {
            return UpdateForm(data: state.barang);
          }
          if (state is BarangError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

}
