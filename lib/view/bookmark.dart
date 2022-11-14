import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shollutech_v5/view/home_screen.dart';

import '../models/Surat.dart';
import '../services/sqlitehelper.dart';
import 'detailsurat.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({Key? key}) : super(key: key);

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  SQLiteHelper? helper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper = SQLiteHelper();
    helper!.inisiasiDB().whenComplete(() async {
      // await helper.tambahKucing();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#40B07A"),
        title: Row(
              children: [
                Text(
                  "Book",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Text(
                  "mark",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          },
        ),
      ),
      body: FutureBuilder(
        future: helper!.ambilDataSurat(),
        builder:(BuildContext context, AsyncSnapshot<List<SuratModel>> snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailSurat(
                                  nomor: snapshot.data![index].nomor,
                                  namaSurat: snapshot.data![index].nama,
                                  asmaSurat: snapshot.data![index].asma,
                                  artiSurat: snapshot.data![index].arti,
                                )));
                  },
                  child: Dismissible(
                    key: ValueKey<int?>(snapshot.data![index].id),
                    onDismissed: (DismissDirection direction) async {
                        await helper!.deleteDataSurat(snapshot.data![index].id);
                      },
                    child: Card(
                      borderOnForeground: false,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text("QS. "+snapshot.data![index].nama+": Ayat "+snapshot.data![index].ayat),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                            child: Text(
                              snapshot.data![index].teks + "  ("+snapshot.data![index].ayat+")  ",
                              style: TextStyle(fontFamily: "MADDINA", fontSize: 20),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
