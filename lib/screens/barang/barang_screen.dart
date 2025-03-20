import 'package:express_inventory/cubit/barang/barang_cubit.dart';
import 'package:express_inventory/model/Barang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarangScreen extends StatefulWidget {
  const BarangScreen({super.key});

  @override
  State<BarangScreen> createState() => _BarangScreenState();
}

class _BarangScreenState extends State<BarangScreen> {
  @override
  void initState() {
    loadBarang();
    super.initState();
  }

  void loadBarang() {
    context.read<BarangCubit>().fetchBarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Barang',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: BlocConsumer<BarangCubit, BarangState>(
        listener: (BuildContext context, BarangState state) {
          print(state);
        },
        builder: (context, state) {
          if (state is BarangLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BarangLoaded) {
            if (state.barang.isEmpty) {
              return const Center(child: Text('Post Empty'));
            }
            return showListBarang(state.barang);
          }
          if (state is BarangError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/barang/add').then((_){
            context.read<BarangCubit>().fetchBarang();
          });
        },
        backgroundColor: const Color(0xFFE0E0E0),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Padding showListBarang(List<Barang> barang) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.48,
        children: List.generate(barang.length, (index) {
          Barang data = barang[index];
          return _buildItemCard(data);
        }),
      ),
    );
  }

  Widget _buildItemCard(Barang barang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          barang.gambar!,
          height: 130,
          width: 130,
          fit: BoxFit.cover,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/barang/update', arguments: {
                  "id" : barang.id
                }).then((_){
                  context.read<BarangCubit>().fetchBarang();

                });

                context.read<BarangCubit>().detailBarang(id: barang.id!.toInt());
              },
              child: Icon(Icons.edit),
            ),

            ElevatedButton(onPressed: () async{
              await context.read<BarangCubit>().deleteBarang(barang.id!.toInt());
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Delete Success!'), backgroundColor: Colors.green,));
              await context.read<BarangCubit>().fetchBarang();
            }, child: Icon(Icons.close)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          barang.namaBarang!,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          barang.keterangan!,
          style: TextStyle(fontSize: 12, color: Colors.black87),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "Stok : ${barang.stok}",
          style: TextStyle(fontSize: 24, color: Colors.black87),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
