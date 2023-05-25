import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataApi extends StatefulWidget {
  const DataApi({super.key});

  @override
  State<DataApi> createState() => _DataApiState();
}

class _DataApiState extends State<DataApi> {
  late Future<List> futureAlbum;

  Future<List<dynamic>> fetchMyData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchMyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Data Api',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black)),
        body: Center(
            child: FutureBuilder<List>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]['title']),
                    subtitle: Text(snapshot.data![index]['body']),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Text('data error');
            }

            return const CircularProgressIndicator(
              strokeWidth: 8.0,
              backgroundColor: Colors.black,
              color: Colors.white,
            );
          },
        )));
  }
}
