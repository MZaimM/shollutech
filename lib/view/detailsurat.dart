import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../models/Surat.dart';
import '../services/apiservice.dart';
import '../services/sqlitehelper.dart';
import 'bookmark.dart';

class DetailSurat extends StatelessWidget {
  String? nomor;
  String? namaSurat;
  String? asmaSurat;
  String? artiSurat;
  DetailSurat(
      {Key? key,
      required this.nomor,
      required this.namaSurat,
      required this.asmaSurat,
      required this.artiSurat})
      : super(key: key);

  SQLiteHelper? helper;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#40B07A"),
        title: Row(
          children: [
            Text(
              "Detail",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            Text(
              " Surat",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
        elevation: 0,
        // backgroundColor: Colors.white,
      ),
      body: Container(
        // color: Colors.white,
        margin: EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 12,
            ),
            Card(
              shadowColor: HexColor("#40B07A"),
              elevation: 4,
              margin: EdgeInsets.only(right: 20, left: 20),
              color: HexColor("#40B07A"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: 141,
                width: 370,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage('assets/bg.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // SvgPicture.asset('assets/icons/quran.svg'),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      namaSurat!,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      asmaSurat!,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      artiSurat!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: FutureBuilder(
                  future: ApiService.getAyatData(nomor),
                  builder: (context, AsyncSnapshot<List<SuratModel>> snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onLongPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Bookmark"),
                                          content: Text("Ingin menyimpan surat terakhir yang di baca?"),
                                          elevation: 24.0,
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () async {
                                                var input = SuratModel(
                                                    nomor: nomor!,
                                                    nama: namaSurat!,
                                                    asma: asmaSurat!,
                                                    arti: artiSurat!,
                                                    ayat: snapshot.data![i].ayat,
                                                    teks: snapshot.data![i].teks);
                                                // insert data to bookmark
                                                helper = SQLiteHelper();
                                                helper!.inisiasiDB().whenComplete(() async {
                                                  await helper!.insertSurat(input);
                                                });
                                                Navigator.pushReplacement(context,MaterialPageRoute(
                                                        builder: (context) => Bookmark()));
                                              },
                                              color: Colors.white,
                                              elevation: 0,
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                    color: HexColor("#B068D0")),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              color: Colors.white,
                                              elevation: 0,
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                    color: HexColor("#B068D0")),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Card(
                                    elevation: 2,
                                    shadowColor: HexColor("#B068D0"),
                                    child: ListTile(
                                      //trailing: Text("("+snapshot.data[i].ayat+") "),
                                      title: Container(
                                        margin: EdgeInsets.only(left: 24),
                                        child: Text(
                                          snapshot.data![i].teks +
                                              "  (" +
                                              snapshot.data![i].ayat +
                                              ")  ",
                                          style: TextStyle(
                                              fontFamily: "MADDINA",
                                              fontSize: 20),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    )),
                              );
                            }),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
