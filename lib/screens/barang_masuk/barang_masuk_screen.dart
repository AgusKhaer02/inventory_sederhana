import 'package:express_inventory/cubit/barang_masuk/barang_masuk_cubit.dart';
import 'package:express_inventory/model/DataBarangInOut.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarangMasukScreen extends StatefulWidget {
  const BarangMasukScreen({super.key});

  @override
  State<BarangMasukScreen> createState() => _BarangMasukScreenState();
}

class _BarangMasukScreenState extends State<BarangMasukScreen> {
  @override
  void initState() {
    loadBarang();
    super.initState();
  }

  void loadBarang() {
    context.read<BarangMasukCubit>().fetchBarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Barang Masuk',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<BarangMasukCubit, BarangMasukState>(
        listener: (context, state) async {
          if (state is BarangMasukDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Delete Success!'),
                backgroundColor: Colors.green,
              ),
            );
            await context.read<BarangMasukCubit>().fetchBarang();
          }
        },
        builder: (context, state) {
          if (state is BarangMasukLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BarangMasukLoaded) {
            if (state.barang.isEmpty) {
              return const Center(child: Text('Post Empty'));
            }
            return showList(state.barang);
          }
          if (state is BarangMasukError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/input-barang-masuk').then((value) {
            loadBarang();
          });
        },
        backgroundColor: const Color(0xFFE0E0E0),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  ListView showList(List<DataBarangInOut> data) {
    return ListView.builder(
      itemCount: data.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              title: Text(
                data[index].namaBarang!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                'Jumlah: ${data[index].jumlah}',
                style: TextStyle(fontSize: 14),
              ),
              trailing: GestureDetector(
                onTap: () async {
                  await context.read<BarangMasukCubit>().deleteBarang(
                    data[index].id!.toInt(),
                  );

                },
                child: const Icon(Icons.close),
              ),
            ),
          ),
        );
      },
    );
  }
}
