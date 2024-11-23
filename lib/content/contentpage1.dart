import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Contentpage1 extends StatefulWidget {
  final String url1;
  const Contentpage1(this.url1, {super.key});

  @override
  State<Contentpage1> createState() => _ContentpageState();
}

class _ContentpageState extends State<Contentpage1> {
  List<dynamic> users = [];
  bool isDataLoaded = false;

  Future<void> fetchdata() async {
    var url = widget.url1;
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
    return isDataLoaded?Scaffold(
        appBar: AppBar(
          title: Text(users[0]['subtitle']),
        ),
        body: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final head = user['head'];
                  final body = user['body'];
                  return ListTile(
                    title: Text(head),
                    subtitle: Text(body),
                  );
                },
              )
            ):const Scaffold();
  }
}