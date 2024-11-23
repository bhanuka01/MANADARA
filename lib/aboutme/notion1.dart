// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';
//
// Future<void> appendTextToNotionBlock(String notionToken, String blockId, String text) async {
//   final url = Uri.parse('https://api.notion.com/v1/blocks/$blockId/children');
//
//   final headers = {
//     'Authorization': 'Bearer $notionToken',
//     'Notion-Version': '2022-06-28', // Or later
//     'Content-Type': 'application/json',
//   };
//
//   final body = jsonEncode({
//     "children": [
//       {
//         "object": "block",
//         "type": "paragraph",
//         "paragraph": {
//           "rich_text": [
//             {
//               "type": "text",
//               "text": {"content": text},
//             },
//           ],
//         },
//       },
//     ],
//   });
//
//   final response = await http.patch(url, headers: headers, body: body);
//
//   if (response.statusCode == 200) {
//     print('Text appended successfully');
//   } else {
//     print('Failed to append text: ${response.statusCode} - ${response.body}');
//     throw Exception('Failed to append text to Notion block');
//   }
// }
//
// class Notion1 extends StatefulWidget {
//   const Notion1({super.key});
//
//   @override
//   State<Notion1> createState() => _NotionState();
// }
//
// class _NotionState extends State<Notion1> {
//   List<String> _pendingTexts = [];
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//
//   final String notionToken = 'secret_ii3cLWpXAxuS8xNg7hupQyqNDjMxAOPwrGfWQViV3iQ'; // Replace!
//   final String blockId = '2fa9cf96bae74e178e3062b11d8bc36c';     // Replace!
//
//   @override
//   void initState() {
//     super.initState();
//     _loadPendingTexts();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }
//
//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }
//
//   Future<void> _loadPendingTexts() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _pendingTexts = prefs.getStringList('pending_notion_texts') ?? [];
//     setState(() {});
//   }
//
//   Future<void> _savePendingTexts() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('pending_notion_texts', _pendingTexts);
//   }
//
//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     if (result != ConnectivityResult.none && _pendingTexts.isNotEmpty) {
//       await _sendPendingTexts();
//     }
//   }
//
//   Future<void> _sendPendingTexts() async {
//     for (String text in List.from(_pendingTexts)) {
//       try {
//         await appendTextToNotionBlock(notionToken, blockId, text);
//         _pendingTexts.remove(text);
//       } catch (e) {
//         print('Error sending pending text: $e');
//         // If there's an error, the text remains in _pendingTexts
//         // for the next attempt.
//       }
//     }
//     await _savePendingTexts(); // Save updated list
//     setState(() {});         // Update UI
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Notion Text Appender")),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               const textToAdd = 'This is the text I want to add.';
//               _pendingTexts.add(textToAdd);
//               await _savePendingTexts();
//               if (await _connectivity.checkConnectivity() != ConnectivityResult.none) {
//                 await _sendPendingTexts();
//               }
//               setState(() {});
//             },
//             child: const Text("Add Text to Notion"),
//           ),
//           Expanded( // To make the ListView take the remaining space
//             child: _pendingTexts.isEmpty
//                 ? const Center(child: Text("No pending texts."))
//                 : ListView.builder(
//               itemCount: _pendingTexts.length,
//               itemBuilder: (context, index) => ListTile(
//                 title: Text(_pendingTexts[index]),
//               ),
//             ),
//
//           ),
//
//         ],
//       ),
//     );
//   }
// }