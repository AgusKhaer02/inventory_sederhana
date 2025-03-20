import 'dart:io';

import 'package:express_inventory/cubit/barang/barang_cubit.dart';
import 'package:express_inventory/model/Barang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateForm extends StatefulWidget {
  final Barang data;
  const UpdateForm({super.key, required this.data});

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  File? _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _keteranganController = TextEditingController();


  @override
  void dispose() {
    _namaController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // _image = File.fromUri(Uri.parse(widget.data.gambar!));
    super.initState();
  }

  Future getImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
          });
          print("Lokasi Gambar : ${pickedFile.path}");
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('No Image Selected')));
        }


    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      });
    }
  }

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) return;

    if (_image != null) {
      context.read<BarangCubit>().updateBarang(
        image: _image!,
        namaBarang: _namaController.text,
        keterangan: _keteranganController.text,
        id: widget.data.id!.toInt(),
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


  @override
  Widget build(BuildContext context) {

    _namaController.text = widget.data.namaBarang!;
    _keteranganController.text = widget.data.keterangan!;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child:
                _image == null
                    ? Image.network(widget.data.gambar!)
                    : Image.file(_image!, height: 200, width: 200, fit: BoxFit.cover,),
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
    );
  }
}
