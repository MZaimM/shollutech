import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class DetailArtikel extends StatelessWidget {
  String nama;
  String gambar;
  String detail;
  
  DetailArtikel({super.key, required this.nama, required this.gambar, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Artikel"),
        backgroundColor: HexColor("#40B07A"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 24, right: 24, top: 24),
        child: ListView(
          children: <Widget>[
            Image.network(
              gambar,
              height: 280,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16,),
            Text(nama, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
            Text(detail, style: TextStyle(fontSize: 14),)
          ],
        ),
      ),
    );
  }
}