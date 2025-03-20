import 'dart:io';

import 'package:express_inventory/cubit/barang/barang_cubit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputBarangScreen extends StatefulWidget {
  const InputBarangScreen({super.key});

  @override
  State<InputBarangScreen> createState() => _InputBarangScreenState();
}

class _InputBarangScreenState extends State<InputBarangScreen> {
  int quantity = 16;

  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _keteranganController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  late BarangCubit barangCubit;

  @override
  void initState() {
    barangCubit = BarangCubit();
    super.initState();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) return;

    if (_image != null) {
      await barangCubit.createBarang(
        image: _image!,
        namaBarang: _namaController.text,
        keterangan: _keteranganController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Input Berhasil'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Insert Image'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future getImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('No Image Selected')));
        }
      });
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      });
    }
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child:
                      _image == null
                          ? const Text('No Image Selected')
                          : Image.file(_image!, height: 200, width: 200),
                ),
                const SizedBox(height: 8.0),
                TextButton(
                  onPressed: () => getImage(),
                  child: const Text('Selected Image'),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _namaController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Nama Barang',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silahkan Input Nama Barang';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _keteranganController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Keterangan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silahkan Input Keterangan';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _submitData,
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
