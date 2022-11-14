import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shollutech_v5/view/detail_artikel.dart';

import '../models/data.dart';
import '../services/data_services.dart';

class SholatPage extends StatefulWidget {
  const SholatPage({super.key});

  @override
  State<SholatPage> createState() => _SholatPageState();
}

class _SholatPageState extends State<SholatPage> {
  Widget card() {
    return Card(
      color: HexColor("#40B07A"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 144,
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.png"), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "SholluTech",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Solution for learning" + " sholat",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget card_blog(String nama, String gambar, String detail,
      AsyncSnapshot<List<Data>> snapshot, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(
              snapshot.data![index].gambar,
              height: 280,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Tata Cara Sholat",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Turn down the world's noise with the long-lasting noise cancellation performance of the WH-CH710N wireless headphones",
              maxLines: 2,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: Container(
      margin: EdgeInsets.only(top: 56, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          card(),
          SizedBox(
            height: 24,
          ),
          Text(
            "Popular Feature",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: FutureBuilder<List<Data>>(
              future: DataServices.getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return const Text('Woops something wrong');
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailArtikel(
                                              nama: snapshot.data![index].nama,
                                              gambar:
                                                  snapshot.data![index].gambar,
                                              detail:
                                                  snapshot.data![index].detail,
                                            )));
                              },
                              child: card_blog(
                                  snapshot.data![index].nama,
                                  snapshot.data![index].gambar,
                                  snapshot.data![index].detail,
                                  snapshot,
                                  index),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}
