import 'dart:convert';

import 'package:http/http.dart' as http;

class SuratModel{
  String nama, asma, arti, ayat, teks;
  String nomor;
  int? id;

  SuratModel({
    this.id,
    required this.nomor,
    required this.nama,
    required this.asma,
    required this.arti,
    required this.ayat,
    required this.teks
  });

  factory SuratModel.fromJson(Map<String, dynamic> json){
    return SuratModel(
      nama: json['nama'] == null ? "":json['nama'],
      asma: json['asma'] == null ? "":json['asma'],
      arti: json['arti'] == null ? "":json['arti'],
      ayat: json['ayat'] == null ? "":json['ayat'],
      teks: json['teks'] == null ? "":json['teks'],
      nomor: json['nomor'] == null ? "":json['nomor'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'nomor': nomor, 'nama': nama, 'asma' : asma, 'arti':arti, 'ayat': ayat, 'teks':teks};
  }
}
// class Surat {
//   String nomor, nama, asma, arti;

//   Surat({
//     this.nomor, this.nama, this.asma, this.arti
//   });

//   factory Surat.createSurat(Map<String,dynamic> object){
//     return Surat(
//       nomor: object['nomor'],
//       nama: object['nama'],
//       asma: object['asma'],
//       arti: object['arti']
//     );
//   }

//   getSuratFromAPI() async{
//     String apiURL = 'https://api.banghasan.com/quran/format/json/surat';
//     var apiResult = await http.get(Uri.parse(apiURL));
//     var jsonObject = json.decode(apiResult.body);
//     var dataSurat = (jsonObject as Map<String, dynamic>)['hasil'];

//     List<Surat> listSurat = [];

//     for (var i = 0; i < dataSurat.length; i++) {
//       listSurat.add(Surat.createSurat(dataSurat[i]));
//       return listSurat;
//     }

//   } 

  
