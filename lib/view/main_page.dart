import 'package:flutter/material.dart';
import 'package:shollutech_v5/models/data.dart';
import 'package:shollutech_v5/services/data_services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('-')),
      body: FutureBuilder<List<Data>>(
        future: DataServices.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return const Text('Woops something wrong');
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.network(
                        snapshot.data![index].gambar,
                        height: 280,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Text(snapshot.data![index].nama),
                      Text(snapshot.data![index].detail),
                    ],
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
