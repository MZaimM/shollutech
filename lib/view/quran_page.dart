import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:searchfield/searchfield.dart';

import '../models/Surat.dart';
import '../services/apiservice.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      ApiService.getSuratFromAPI();
    });
  }

  

  @override
  Widget build(BuildContext context) {

    var _surah = {"alfatihah","albaqarah"};

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white,toolbarHeight: 24,),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Bacalah Quran Supaya"+"\n"+ "Hatimu Tenang 🤲",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            SizedBox(
              height: 12,
            ),
            
            Expanded(
              child: FutureBuilder(
                  future: ApiService.getSuratFromAPI(),
                  builder: (context, AsyncSnapshot<List<SuratModel>> snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              return Card(
                                  shadowColor: HexColor("#B068D0"),
                                  elevation: 2,
                                  child: ListTile(
                                    leading: Text(
                                      "(" +
                                          snapshot.data![i].nomor.toString() +
                                          ")",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#B068D0")),
                                    ),
                                    title: Text(
                                      snapshot.data![i].nama,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700),
                                    ),
                                    subtitle: Text(
                                      snapshot.data![i].arti,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: HexColor("#B068D0")),
                                    ),
                                    trailing: Text(
                                      snapshot.data![i].asma,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => DetailSurat(
                                      //               nomor: snapshot.data![i].nomor,
                                      //               namaSurat:
                                      //                   snapshot.data![i].nama,
                                      //               asmaSurat:
                                      //                   snapshot.data![i].asma,
                                      //               artiSurat:
                                      //                   snapshot.data![i].arti,
                                      //             )));
                                    },
                                  ));
                            });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
