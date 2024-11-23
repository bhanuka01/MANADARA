// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// // ... (addTextToNotion function remains the same)
//
// class Notion extends StatefulWidget {
//   final String notionApiKey;
//   final String databaseId;
//
//   const Notion({
//     super.key,
//     required this.notionApiKey,
//     required this.databaseId,
//   });
//
//   @override
//   State<Notion> createState() => _NotionDatabaseState();
// }
//
// class _NotionDatabaseState extends State<Notion> {
//   List<Map<String, dynamic>> _databaseRows = [];
//   Timer? _timer;
//   final TextEditingController _textController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _refreshData(); // Initial data fetch
//     _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
//       _refreshData(); // Fetch data every 10 seconds
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel(); // Cancel the timer to avoid memory leaks
//     super.dispose();
//   }
//
//   Future<void> addTextToNotion(
//       String text, String databaseId, String notionApiKey) async {
//     final url = Uri.parse('https://api.notion.com/v1/pages');
//
//     final headers = {
//       'Authorization': 'Bearer $notionApiKey',
//       'Notion-Version': '2022-06-28', // Or latest version
//       'Content-Type': 'application/json',
//     };
//
//     final body = jsonEncode({
//       "parent": {"database_id": databaseId},
//       "properties": {
//         "Name": {
//           // Replace "Name" with the name of your text property in Notion
//           "title": [
//             {
//               "text": {"content": text}
//             }
//           ]
//         }
//         // Add more properties as needed, following the Notion API format.
//         // Example:
//         // "Status": {
//         //   "select": {"name": "In Progress"}
//         // },
//         // "Due Date": {
//         //   "date": {"start": "2024-03-15"}
//         // }
//       }
//     });
//
//     try {
//       final response = await http.post(url, headers: headers, body: body);
//
//       if (response.statusCode == 200) {
//         // print('Text added to Notion successfully.');
//         // You can parse the response here if needed:
//         // final data = jsonDecode(response.body);
//         // print(data);
//       } else {
//         // print('Error adding text to Notion: ${response.statusCode}');
//         // print(response.body); // Print the error response for debugging.
//       }
//     } catch (e) {
//       // print('Error adding text to Notion: $e');
//     }
//   }
//
//   Future<void> _refreshData() async {
//     final url = Uri.parse(
//         'https://api.notion.com/v1/databases/${widget.databaseId}/query');
//     final headers = {
//       'Authorization': 'Bearer ${widget.notionApiKey}',
//       'Notion-Version': '2022-06-28',
//       'Content-Type': 'application/json',
//     };
//
//     try {
//       final response = await http.post(url, headers: headers);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           _databaseRows = List<Map<String, dynamic>>.from(data['results']);
//         });
//       } else {
//         // print('Error fetching data: ${response.statusCode}');
//         // print(response.body);
//       }
//     } catch (e) {
//       // print('Error fetching data: $e');
//     }
//   }
//
//   // Future<void> _deleteRow(String pageId) async {
//   //   final url = Uri.parse('https://api.notion.com/v1/pages/$pageId');
//   //   final headers = {
//   //     'Authorization': 'Bearer ${widget.notionApiKey}',
//   //     'Notion-Version': '2022-06-28',
//   //     'Content-Type': 'application/json',
//   //   };
//   //
//   //   try {
//   //     final response = await http.delete(
//   //         url,
//   //         headers: headers
//   //     );
//   //
//   //     if (response.statusCode == 200) {
//   //       print('Row deleted successfully.');
//   //       _refreshData(); // Refresh data after successful deletion
//   //     } else {
//   //       print('Error deleting row : ${response.statusCode}');
//   //       print(response.body);
//   //
//   //     }
//   //   } catch (e) {
//   //     print('Error deleting row: $e');
//   //   }
//   // }
//
//   Future<void> updateRow(String pageId, String newText) async {
//     final url = Uri.parse('https://api.notion.com/v1/pages/$pageId');
//
//     final headers = {
//       'Authorization': 'Bearer ${widget.notionApiKey}',
//       'Notion-Version': '2022-06-28', // Or latest
//       'Content-Type': 'application/json',
//     };
//
//     final body = jsonEncode({
//       "properties": {
//         "Name": {
//           // Assuming "Name" is your property name
//           "title": [
//             {
//               "text": {"content": newText}
//             }
//           ]
//         }
//       }
//     });
//
//     try {
//       final response = await http.patch(url, headers: headers, body: body);
//
//       if (response.statusCode == 200) {
//         _refreshData();
//         // print("Row updated successfully");
//         // Optional: Handle success, e.g., show a success message.
//       } else {
//         // print('Error updating row: ${response.statusCode}');
//         // print(response.body);
//         // Handle error, e.g., display an error message to the user.
//       }
//     } catch (e) {
//       // print('Error updating row: $e'); // Handle any exceptions that occurred
//     }
//   }
//   Future<void> _updateCheckbox(String pageId, bool isChecked) async {
//     final url = Uri.parse('https://api.notion.com/v1/pages/$pageId');
//     final headers = {
//       'Authorization': 'Bearer ${widget.notionApiKey}',
//       'Notion-Version': '2022-06-28',
//       'Content-Type': 'application/json',
//     };
//
//     final body = jsonEncode({
//       "properties": {
//         "Checkbox": { // Replace with your checkbox property name
//           "checkbox": isChecked
//         },
//       },
//     });
//
//     try {
//       final response = await http.patch(url, headers: headers, body: body);
//
//       if (response.statusCode == 200) {
//         _refreshData(); // Refresh the data after updating the checkbox
//         // print("Checkbox updated successfully");
//       } else {
//         // print("Error updating checkbox: ${response.statusCode}");
//         // print(response.body);
//       }
//     } catch (e) {
//       // print('Error updating checkbox: $e');
//     }
//   }
//
//   // void _showUpdateDialog(String pageId, String currentText) {
//   //   _textController.text = currentText; // Pre-fill with current text
//   //
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) => AlertDialog(
//   //       title: const Text('Update Text'),
//   //       content: TextField(
//   //         controller: _textController,
//   //       ),
//   //       actions: [
//   //         TextButton(
//   //           onPressed: () {
//   //             Navigator.of(context).pop(); // Close the dialog
//   //           },
//   //           child: const Text('Cancel'),
//   //         ),
//   //         TextButton(
//   //           onPressed: () async {
//   //             await updateRow(pageId, _textController.text);
//   //             Navigator.of(context).pop(); // Close the dialog
//   //           },
//   //           child: const Text('Update'),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   void _showUpdateDialog(String pageId, String currentText) {
//     _textController.text = currentText; // Pre-fill with current text
//
//     final isDarkMode = Theme.of(context).brightness == Brightness.light;
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white, // Dark mode background
//         title: Text(
//           'Update Text',
//           style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), // Text color for title
//         ),
//         content: TextField(
//           controller: _textController,
//           style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), // Text color for input
//           decoration: InputDecoration(
//             hintText: 'Enter text here',
//             hintStyle: TextStyle(color: isDarkMode ? Colors.grey : Colors.black38), // Hint color
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: isDarkMode ? Colors.white : Colors.black),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: isDarkMode ? Colors.blue : Colors.blue),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text(
//               'Cancel',
//               style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), // Button text color
//             ),
//           ),
//           TextButton(
//             onPressed: () async {
//               await updateRow(pageId, _textController.text);
//               // ignore: use_build_context_synchronously
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text(
//               'Update',
//               style: TextStyle(color: isDarkMode ? Colors.blue : Colors.blue), // Button text color
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         foregroundColor: Colors.white,
//         backgroundColor: Colors.transparent,
//         title: const Text('Notion Database',style: TextStyle(fontSize: 25),),
//       ),
//       body: _databaseRows.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _databaseRows.length,
//               itemBuilder: (context, index) {
//                 final row = _databaseRows[index];
//                 final pageId = row['id'];
//                 final title = row['properties']['Name']['title']
//                         .isNotEmpty //check not empty
//                     ? row['properties']['Name']['title'][0]['plain_text']
//                     : 'No title';
//                 final checkboxValue = row['properties']
//                 ['Checkbox']?['checkbox'] ?? false;
//
//                 return ListTile(
//                   title: InkWell(
//                       onTap: () {
//                         _showUpdateDialog(pageId, title);
//                       },
//                       child: Text(
//                         title,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 25,
//                         ),
//                       ),), // Display the title
//                   trailing: Transform.scale(
//                     scale: 1.5,
//                     child: Checkbox(
//                       value: checkboxValue, // Use the retrieved checkbox value
//                       onChanged: (value) {
//                         if (value != null) {
//                           _updateCheckbox(pageId, value);
//                         }
//                       },
//                       // checkColor: Colors.tealAccent,
//                       focusColor: Colors.tealAccent,
//                       hoverColor: Colors.tealAccent,
//                       activeColor: Colors.tealAccent,
//                       splashRadius: 20,
//
//
//
//                     ),
//                   ),
//
//                   // trailing: IconButton(
//                   //   icon: const Icon(Icons.delete),
//                   //   onPressed: () => _deleteRow(pageId),
//                   // ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//           showDialog(
//             context: context,
//             builder: (context) =>
//                 AlertDialog(
//               backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white, // Dark mode background
//               title: Text(
//                 "Add New Item",
//                 style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), // Title text color
//               ),
//               content: TextField(
//                 controller: _textController,
//                 style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), // Input text color
//                 decoration: InputDecoration(
//                   hintText: 'Enter new item',
//                   hintStyle: TextStyle(color: isDarkMode ? Colors.grey : Colors.black38), // Hint color
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: isDarkMode ? Colors.white : Colors.black),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: isDarkMode ? Colors.blue : Colors.blue),
//                   ),
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text(
//                     "Cancel",
//                     style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), // Button text color
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () async {
//                     try {
//                       await addTextToNotion(
//                         _textController.text,
//                         widget.databaseId,
//                         widget.notionApiKey,
//                       );
//                       _refreshData();
//                       // ignore: use_build_context_synchronously
//                       Navigator.pop(context);
//                       _textController.clear();
//
//                       // ignore: use_build_context_synchronously
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                             "Row added successfully",
//                             style: TextStyle(color: isDarkMode ? Colors.white : Colors.black), // SnackBar text color
//                           ),
//                           backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[300], // SnackBar background color
//                         ),
//                       );
//                     } catch (e) {
//                       // print(e);
//                     }
//                   },
//                   child: Text(
//                     "Add",
//                     style: TextStyle(color: isDarkMode ? Colors.blue : Colors.blue), // Button text color
//                   ),
//                 )
//               ],
//             ),
//
//
//           //       AlertDialog(
//           //     title: const Text("Add New Item"),
//           //     content: TextField(controller: _textController),
//           //     actions: [
//           //       TextButton(
//           //           onPressed: () => Navigator.pop(context),
//           //           child: const Text("Cancel")),
//           //       TextButton(
//           //         onPressed: () async {
//           //           try {
//           //             await addTextToNotion(_textController.text,
//           //                 widget.databaseId, widget.notionApiKey);
//           //             _refreshData();
//           //             Navigator.pop(context);
//           //             _textController.clear();
//           //
//           //             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           //               content: Text("Row added successfully"),
//           //             ));
//           //           } catch (e) {
//           //             print(e);
//           //           }
//           //         },
//           //         child: const Text("Add"),
//           //       )
//           //     ],
//           //   ),
//           );
//
//           // try {
//           //
//           // } catch (e) {
//           //   print(e);
//           // }
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// // ... (Your Notion widget and main function)
// // import 'dart:async';
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// //
// // Future<void> addTextToNotion(String text, String databaseId, String notionApiKey) async {
// //   final url = Uri.parse('https://api.notion.com/v1/pages');
// //
// //   final headers = {
// //     'Authorization': 'Bearer $notionApiKey',
// //     'Notion-Version': '2022-06-28', // Or latest version
// //     'Content-Type': 'application/json',
// //   };
// //
// //   final body = jsonEncode({
// //     "parent": {"database_id": databaseId},
// //     "properties": {
// //       "Name": { // Replace "Name" with the name of your text property in Notion
// //         "title": [
// //           {
// //             "text": {"content": text}
// //           }
// //         ]
// //       }
// //       // Add more properties as needed, following the Notion API format.
// //       // Example:
// //       // "Status": {
// //       //   "select": {"name": "In Progress"}
// //       // },
// //       // "Due Date": {
// //       //   "date": {"start": "2024-03-15"}
// //       // }
// //     }
// //   });
// //
// //
// //   try {
// //     final response = await http.post(url, headers: headers, body: body);
// //
// //     if (response.statusCode == 200) {
// //       print('Text added to Notion successfully.');
// //       // You can parse the response here if needed:
// //       // final data = jsonDecode(response.body);
// //       // print(data);
// //     } else {
// //       print('Error adding text to Notion: ${response.statusCode}');
// //       print(response.body); // Print the error response for debugging.
// //     }
// //   } catch (e) {
// //     print('Error adding text to Notion: $e');
// //   }
// // }
// //
// // Future<void> appendTextToNotionBlock(String notionToken, String blockId, String text) async {
// //   final url = Uri.parse('https://api.notion.com/v1/blocks/$blockId/children');
// //
// //   final headers = {
// //     'Authorization': 'Bearer $notionToken',
// //     'Notion-Version': '2022-06-28', // Or later, check Notion API docs
// //     'Content-Type': 'application/json',
// //   };
// //
// //
// //   final body = jsonEncode({
// //     "children": [
// //       {
// //         "object": "block",
// //         "type": "paragraph", // Or other block type if needed
// //         "paragraph": {
// //           "rich_text": [
// //             {
// //               "type": "text",
// //               "text": {"content": text},
// //             },
// //           ],
// //         },
// //       },
// //     ],
// //   });
// //
// //   final response = await http.patch(url, headers: headers, body: body);
// //
// //   if (response.statusCode == 200) {
// //     print('Text appended successfully');
// //   } else {
// //     print('Failed to append text: ${response.statusCode} - ${response.body}');
// //     // Handle error appropriately, e.g., show an error message to the user.
// //     throw Exception('Failed to append text to Notion block');
// //   }
// // }
// //
// // class Notion extends StatefulWidget {
// //   const Notion({super.key});
// //
// //
// //   @override
// //   State<Notion> createState() => _NotionState();
// // }
// //
// // class _NotionState extends State<Notion> {
// //   final TextEditingController _textController = TextEditingController();
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     const textToAdd = 'This is the text I want to add from Flutter.';
// //     const notionToken = 'secret_ii3cLWpXAxuS8xNg7hupQyqNDjMxAOPwrGfWQViV3iQ'; // Your token
// //     const blockId = '2fa9cf96bae74e178e3062b11d8bc36c';
// //     const databaseId = '6adad2b85ef941db8d85c220d113a0c1'; // Your block ID
// //
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         foregroundColor: Colors.white,
// //       ),
// //       body: // Conditionally render content
// //      Padding(
// //        padding: const EdgeInsets.all(8.0),
// //        child: Column(
// //          children: [
// //            TextField(
// //
// //              style: TextStyle(
// //                color: Colors.white,
// //                fontSize: 20.0,
// //              ),
// //              controller: _textController,
// //              maxLines: null, // Key for flexible text height
// //              keyboardType: TextInputType.multiline, // For multi-line input
// //              // decoration: const InputDecoration(hintText: "Enter text",),
// //              decoration: InputDecoration(
// //
// //
// //                filled: false,
// //                fillColor: Colors.white,
// //                hintStyle: const TextStyle(color: Colors.white), // Hint text color
// //                labelStyle: const TextStyle(color: Colors.white), // Label text color
// //                focusColor: Colors.white,
// //
// //                labelText: 'idea',
// //                hintText: 'Please enter your idea',
// //                prefixIcon: Icon(Icons.person,color: Colors.white,),
// //
// //                border: OutlineInputBorder(),
// //                enabledBorder: OutlineInputBorder(
// //
// //                  borderSide: BorderSide(color: Colors.white),
// //                  borderRadius: BorderRadius.circular(30)
// //                ),
// //                focusedBorder: OutlineInputBorder(
// //                    borderRadius: BorderRadius.circular(30),
// //                  borderSide: BorderSide(color: Colors.tealAccent),
// //                ),
// //              ),
// //
// //            ),
// //            Row(
// //              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //              children: [
// //                TextButton(
// //                  onPressed: () => Navigator.pop(context),
// //                  child: const Text("Cancel",style: TextStyle(
// //                    color: Colors.grey,
// //                      fontSize: 18
// //                  ),),
// //                ),
// //                TextButton(
// //                  onPressed: () async {
// //
// //
// //                    try {
// //                      await addTextToNotion(_textController.text, databaseId,  notionToken);
// //                      // Navigator.pop(context); // Close the dialog
// //                      ScaffoldMessenger.of(context).showSnackBar(
// //                        const SnackBar(content: Text('Text added!')),
// //                      );
// //                      _textController.clear(); // Clear text field
// //                    } catch (e) {
// //                      print('Error: $e');
// //                      ScaffoldMessenger.of(context).showSnackBar(
// //                        SnackBar(content: Text('Error: $e')),
// //                      );
// //                    }
// //
// //                    // try {
// //                    //   await appendTextToNotionBlock(
// //                    //       notionToken, blockId, _textController.text);
// //                    //   // Navigator.pop(context); // Close the dialog
// //                    //   ScaffoldMessenger.of(context).showSnackBar(
// //                    //     const SnackBar(content: Text('Text added!')),
// //                    //   );
// //                    //   _textController.clear(); // Clear text field
// //                    // } catch (e) {
// //                    //   print('Error: $e');
// //                    //   ScaffoldMessenger.of(context).showSnackBar(
// //                    //     SnackBar(content: Text('Error: $e')),
// //                    //   );
// //                    // }
// //                  },
// //                  child: const Text("Add",style: TextStyle(
// //                    fontSize: 18,
// //                    color: Colors.white
// //                  ),),
// //                ),
// //              ],
// //            ),
// //
// //          ],
// //        ),
// //      )
// //     );
// //   }
// // }
// //
// //
// //
// // // Example usage:
