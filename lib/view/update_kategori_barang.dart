import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../controller/kategori_barang_controller.dart';
import '../model/kategori_barang_model.dart';
import 'kategori_barang.dart';

class UpdateKategoriBarang extends StatefulWidget {
  const UpdateKategoriBarang({super.key, this.namaAsal, this.id});
  final int? id;
  final String? namaAsal;

  @override
  State<UpdateKategoriBarang> createState() => _UpdateKategoriBarangState();
}

class _UpdateKategoriBarangState extends State<UpdateKategoriBarang> {
  final kategoriBarangController = KategoriBarangController();

  String? namaBaru;

  void updateKategoriBarang(int id, String namaAsal) async {
    await kategoriBarangController.updateKategoriBarang(id, namaAsal);
  }

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Kategori Barang'),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Nama Kategori Barang',
                labelText: 'Nama Kategori Barang',
              ),
              onChanged: (value) {
                namaBaru = value;
              },
              initialValue: widget.namaAsal,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama Kategori is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  formkey.currentState!.save();
                  kategoriBarangController.updateKategoriBarang(
                      widget.id!, namaBaru!);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const KategoriBarang()));

                  var snackBar =
                      const SnackBar(content: Text('Data Berhasil Terupdate'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('Simpan'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const KategoriBarang())));

                var snackBar =
                    const SnackBar(content: Text('Batal melakukan perubahan'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text('Batalkan'),
            ),
          ],
        ),
      ),
    );
  }
}
