import 'package:express_inventory/cubit/barang/barang_cubit.dart';
import 'package:express_inventory/cubit/barang_keluar/barang_keluar_cubit.dart';
import 'package:express_inventory/model/Barang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputBarangKeluarScreen extends StatefulWidget {
  const InputBarangKeluarScreen({super.key});

  @override
  State<InputBarangKeluarScreen> createState() => _InputBarangKeluarScreenState();
}

class _InputBarangKeluarScreenState extends State<InputBarangKeluarScreen> {
  int quantity = 0;
  int dropdownBarang = 0;

  insertBarangMasuk() async {
    await context.read<BarangKeluarCubit>().createBarang(
      idBarang: dropdownBarang.toString(),
      jumlah: quantity.toString(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Input Berhasil'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Barang Keluar',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<BarangCubit, BarangState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is BarangLoaded) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    alignment: Alignment.center,
                    child: DropdownButton<int>(
                      value: (dropdownBarang == 0) ? null : dropdownBarang,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      onChanged: (int? value) {
                        setState(() {
                          dropdownBarang = value!;
                        });
                      },
                      items:
                      state.barang.map<DropdownMenuItem<int>>((
                          Barang value,
                          ) {
                        return DropdownMenuItem<int>(
                          value: value.id!.toInt(),
                          child: Text(value.namaBarang!),
                        );
                      }).toList(),
                    ),
                  );
                }

                return SizedBox();
              },
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircleButton(
                  icon: Icons.remove,
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                ),
                const SizedBox(width: 16),
                Text(
                  '$quantity',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                _buildCircleButton(
                  icon: Icons.add,
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.center,
              child: ElevatedButton(onPressed: () {

                insertBarangMasuk();
              }, child: Text("Tambah")),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: Color(0xFFE0E0E0),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }
}
