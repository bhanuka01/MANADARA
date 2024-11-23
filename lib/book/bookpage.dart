import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../content/contentpage1.dart';

class Bookpage extends StatefulWidget {
  final String url1;
  const Bookpage(this.url1, {super.key});

  @override
  State<Bookpage> createState() => _ContentpageState();
}

class _ContentpageState extends State<Bookpage> {
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
    return isDataLoaded
        ? Scaffold(
            appBar: AppBar(
              title: Text(users[0]['title']),
            ),
            body: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                // final head = user['head'];
                // final body = user['body'];
                final subtitle = user['subtitle'];
                final url1 = user['url'];
                return ListTile(
                  title: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Contentpage1(url1),
                          ),
                        );
                      },
                      child: Text(subtitle)),
                  // subtitle:Text(body) ,
                );
              },
            ),
          )
        : const Scaffold();
  }
}
