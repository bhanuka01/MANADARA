import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Contentpage extends StatefulWidget {
  const Contentpage({super.key});

  @override
  State<Contentpage> createState() => _ContentpageState();
}

class _ContentpageState extends State<Contentpage> {
  List<dynamic> users = [];
  bool isDataLoaded = false;
  Future<void> fetchdata() async {
    const url =
        "https://raw.githubusercontent.com/bhanuka01/pothlanthaya/main/48law/law1.json";
    final uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      setState(() {
        isDataLoaded = true;
      });
      final json = jsonDecode(body);
      setState(() {
        users = json['data'];
      });
    } else {}
  }
  @override
  void initState() {
    super.initState();
    // Initialize the counter
    fetchdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:  isDataLoaded?ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final head = user['head'];
            final body = user['body'];
            return ListTile(
              title: Text(head),
              subtitle:Text(body) ,
            );
          },
        ):const SizedBox()
    );
  }
}
