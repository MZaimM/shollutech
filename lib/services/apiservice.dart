import 'dart:convert';

import '../models/Surat.dart';
import 'package:http/http.dart' as http;

class ApiService{
  static Future<List<SuratModel>> getSuratFromAPI() async{
    var response = await http
        .get(Uri.parse("https://api.banghasan.com/quran/format/json/surat"));
    List<dynamic> jsonData =
        jsonDecode(utf8.decode(response.bodyBytes))['hasil'];

    List<SuratModel> users = [];

    for (var i = 0; i < jsonData.length; i++) {
      users.add(SuratModel.fromJson(jsonData[i]));
    }
    return users;
  } 

  static Future<List<SuratModel>> getAyatData(String? nomor) async{
    
    var response = await http.get(Uri.parse(
      "https://api.banghasan.com/quran/format/json/surat/"+nomor!+"/ayat/1-10"));
    List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes))['ayat']['data']['ar'];

    List<SuratModel> users = [];

    for (var i = 0; i < jsonData.length; i++) {
      users.add(SuratModel.fromJson(jsonData[i]));
    }
    return users;
  }
}