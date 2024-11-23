import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../pdfview/bookpdf.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> users = [];
  bool isDataLoaded = false;
  Future<void> fetchdata() async {
    const url =
        "https://raw.githubusercontent.com/bhanuka01/pothlanthaya/main/pdf/pdf.json";
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

    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF78B3FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF78B3FF),
        title: const Center(
          child: Text(
            'book title', // Make this more prominent
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25, // Increase font size
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: isDataLoaded
          ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Sinhala Transtation",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: users.length,
                  //     itemBuilder: (context, index) {
                  //       final user = users[index];
                  //       final head = user['head'];
                  //       final body = user['body'];
                  //       final url = user['url'];
                  //       return ListTile(
                  //         // title: Text(head),
                  //         // subtitle: Text(body),
                  //         title: ElevatedButton(
                  //             onPressed: () {
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                   builder: (context) => BookPDF(url),
                  //                 ),
                  //               );
                  //             },
                  //             child: Text(head)),
                  //       );
                  //     },
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        final head = user['head'];
                        final url = user['url'];
                        return InkWell(
                            onTap: () {
                              // Navigate to book details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookPDF(url), // Pass book data
                                ),
                              );
                            },
                            child: _buildBookCard(head,
                                "https://m.media-amazon.com/images/I/611X8GI7hpL._SL1500_.jpg"));
                      },
                    ),
                  ),
                ],
              ),
          )
          : const Scaffold(
              backgroundColor: Color(0xFF78B3FF),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  Widget _buildBookCard(String title, String imagePath) {
    return Card(
      elevation: 2, // Add shadow
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              imagePath, // Replace with actual image paths
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// class BookListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'POTH LANTHAYA', // Make this more prominent
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20, // Increase font size
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.person),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0), // Increase padding
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Sinhalese Translation', // Subtitle
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600], // Lighter color
//               ),
//             ),
//             SizedBox(height: 16), // Spacing
//             GridView.count(
//               crossAxisCount: 2,
//               childAspectRatio: 0.7, // Adjust aspect ratio as needed
//               mainAxisSpacing: 16, // Spacing
//               crossAxisSpacing: 16, // Spacing
//               shrinkWrap: true,
//               // physics:
//               //     NeverScrollableScrollPhysics(), // Disable scrolling if needed
//               children: [
//                 _buildBookCard('48 Laws of Power',
//                     'https://m.media-amazon.com/images/I/611X8GI7hpL._SL1500_.jpg'),
//                 _buildBookCard('The Art of Seduction',
//                     'https://m.media-amazon.com/images/I/611X8GI7hpL._SL1500_.jpg'),
//                 _buildBookCard('The 33 Strategies of War',
//                     'https://m.media-amazon.com/images/I/611X8GI7hpL._SL1500_.jpg'),
//                 _buildBookCard('The Laws of Human Nature',
//                     'https://m.media-amazon.com/images/I/611X8GI7hpL._SL1500_.jpg'),
//               ],
//             ),
//             SizedBox(height: 32),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue[800], // Darker color
//                 minimumSize: Size.fromHeight(50),
//               ),
//               onPressed: () {},
//               child: Text('Subscription', style: TextStyle(fontSize: 18)),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue[800], // Darker color
//                   minimumSize: Size.fromHeight(50),
//                 ),
//                 onPressed: () {},
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.add), // Add icon
//                     SizedBox(width: 8),
//                     Text('Add to Library', style: TextStyle(fontSize: 18)),
//                   ],
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBookCard(String title, String imagePath) {
//     return Card(
//       elevation: 2, // Add shadow
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: Image.network(
//               imagePath, // Replace with actual image paths
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               title,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});
//
//   @override
//   State<Homepage> createState() => _HomepageState();
// }
//
// class _HomepageState extends State<Homepage> {
//   List<dynamic> users = [];
//   bool isDataLoaded = false;
//   Future<void> fetchdata() async {
//     const url =
//         "https://raw.githubusercontent.com/bhanuka01/pothlanthaya/main/pdf/pdf.json";
//     final uri = Uri.parse(url);
//     var response = await http.get(uri);
//     if (response.statusCode == 200) {
//       final body = response.body;
//       setState(() {
//         isDataLoaded = true;
//       });
//       final json = jsonDecode(body);
//       setState(() {
//         users = json['data'];
//       });
//     } else {}
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     fetchdata();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF78B3FF),
//       appBar: AppBar(
//         backgroundColor: Color(0xFF78B3FF),
//         title: Center(
//           child: Text(
//             "පොත් ලන්තය",
//             style: TextStyle(
//               fontWeight: FontWeight.w800,
//               fontSize: 25,
//             ),
//           ),
//         ),
//       ),
//       body: isDataLoaded
//           ? Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 30),
//             child: Container(
//               child: Text(
//                 "Sinhala Transtation",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//               child: ListView.builder(
//                 itemCount: users.length,
//                 itemBuilder: (context, index) {
//                   final user = users[index];
//                   final head = user['head'];
//                   final body = user['body'];
//                   final url = user['url'];
//                   return ListTile(
//                     // title: Text(head),
//                     // subtitle: Text(body),
//                     title: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => BookPDF(url),
//                             ),
//                           );
//                         },
//                         child: Text(head)),
//                   );
//                 },
//               ))
//         ],
//       )
//           : Scaffold(
//         backgroundColor: Color(0xFF78B3FF),
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }
