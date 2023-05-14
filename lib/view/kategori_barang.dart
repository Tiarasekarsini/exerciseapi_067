import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_api/controller/kategori_barang_controller.dart';
import 'package:project_api/model/kategori_barang_model.dart';
import 'package:project_api/view/add_kategori_barang.dart';
import 'package:project_api/view/update_kategori_barang.dart';

class KategoriBarang extends StatefulWidget {
  const KategoriBarang({super.key});

  @override
  State<KategoriBarang> createState() => _KategoriBarangState();
}

class _KategoriBarangState extends State<KategoriBarang> {
  final kategoriBarangController = KategoriBarangController();
  List<KategoriBarangModel> listKategoriBarang = [];

  @override
  void initState() {
    super.initState();
    getKategoriBarang();
  }

  void getKategoriBarang() async {
    final KategoriBarang = await kategoriBarangController.getKategoriBarang();
    setState(() {
      listKategoriBarang = KategoriBarang;
    });
  }

  void deleteKategoriBarang(KategoriBarangModel kategoriBarangModel) {
    setState(() {
      listKategoriBarang.remove(kategoriBarangModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Barang'),
      ),
      body: SafeArea(
          child: ListView.builder(
        itemCount: listKategoriBarang.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            title: Text(listKategoriBarang[index].nama),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => UpdateKategoriBarang(
                              namaAsal: listKategoriBarang[index].nama,
                              id: listKategoriBarang[index].id))));
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Alert Box'),
                          content: Text(
                              'Apakah anda yakin ingin menghapus data ini?'),
                          actions: [
                            TextButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () async {
                                Navigator.pop(context);
                                kategoriBarangController
                                    .deleteKategoriBarang(
                                        listKategoriBarang[index].id)
                                    .then((value) {
                                  setState(() {
                                    listKategoriBarang.removeAt(index);
                                  });
                                });

                                var snackBar = const SnackBar(
                                    content: Text('Data Telah Terhapus'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                            )
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.delete_outline_rounded),
              )
            ]),
          ));
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddKategoriBarang()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
