import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Photo {
  final String title;
  final String thumbnailUrl;

  Photo({this.title, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        title: json['title'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String);
  }
}

class SimpleFetchData extends StatefulWidget {
  @override
  _SimpleFetchDataState createState() => _SimpleFetchDataState();
}

class _SimpleFetchDataState extends State<SimpleFetchData> {
  List<Photo> listPhoto = List();
  var isLoading = false;

  _fetchData() async {

    setState(() {
      isLoading = true;
    });

    final strURL = "https://jsonplaceholder.typicode.com/photos";
    final response = await http.get(strURL);

    if (response.statusCode == 200) {
      final responseBody = response.body;
      final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
      listPhoto = parsed.map<Photo>((json) => Photo.fromJson(json)).toList();

      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception("Failed to load response");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Fetch Data From API"),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          child: Text("Fetch Data"),
          onPressed: _fetchData,
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: listPhoto.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  title: Text(listPhoto[index].title),
                  trailing: FadeInImage(
                      width: 50.0,
                      height: 50.0,
                      fit: BoxFit.fill,
                      placeholder: AssetImage(
                        "images/default.png",
                      ),
                      image: NetworkImage(
                          listPhoto[index].thumbnailUrl,
                      )
                  ),
                );
              }),
    );
  }
}
