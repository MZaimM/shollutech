import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shollutech_v5/models/data.dart';

class DataServices {
  static Future<List<Data>> getData() async {
    var load = await rootBundle.loadString('assets/data/datasholat.json');
    var data = json.decode(load);
    print(data);
    List<Data> datas =
        (data['data'] as List).map((v) => Data.fromJson(v)).toList();
    return datas;
  }
}
