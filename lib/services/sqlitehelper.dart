import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/Surat.dart';

class SQLiteHelper {
  Future<Database> inisiasiDB() async {
    // membuka database dan menyimpan referensinya
    return openDatabase(
      // mengatur path database menggunakan fungsi join dari
      // paket 'path' untuk memastikan path dibuat dengan benar
      // untuk masing-masing platform.
      join(await getDatabasesPath(), 'muslimhub.db'),
      // ketika database dibuat, buat juga tabel untuk menyimpan data kucing.
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE bookmark(id INTEGER PRIMARY KEY AUTOINCREMENT,' +  
          'nomor VARCHAR, nama VARCHAR, asma VARCHAR, arti VARCHAR,'+
          'ayat VARCHAR, teks TEXT)',
        );
      },
      // Atur versinya untuk melakukan upgrade atau downgrade database.
      version: 1,
    );
  }

  Future<void> insertSurat(SuratModel surat) async {
    // Mendapatkan referensi ke database.
    final db = await inisiasiDB();
    // Insert data kucing ke dalam tabel.
    await db.insert(
      'bookmark',
      surat.toMap(),
      // Jikq data kucing yang di insert sebelumnya sudah ada
      // maka diganti dengan data sebelumnya
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Method untuk mengambil data kucing dari database
  Future<List<SuratModel>> ambilDataSurat() async {
    // Mendapatkan referensi ke database
    final db = await inisiasiDB();
    // Query tabel untuk semua data kucing.
    final List<Map<String, dynamic>> map = await db.query('bookmark');
    // Convert List<Map<String, dynamic>> ke list
    return List.generate(map.length, (i) {
      return SuratModel(
        id: map[i]['id'], nomor: map[i]['nomor'], nama: map[i]['nama'],
        asma: map[i]['asma'], arti: map[i]['arti'], ayat: map[i]['ayat'].toString(), 
        teks: map[i]['teks'],
      );
    });
  }

  // Method untuk menghapus data kucing
  Future<void> deleteDataSurat(int? id) async {
    // Mendapatkan referensi ke database
    final db = await inisiasiDB();
    // Hapus data kucing dari database
    await db.delete('bookmark',
        // menggunakan 'where' untuk menghapus data kucing tertentu
        where: 'id=?',
        // lewatkan id kucing ke argumen 'whereArg' untuk menanggunalngi sql injection.
        whereArgs: [id]);
  }
}