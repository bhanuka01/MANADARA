// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:appwrite/appwrite.dart';
//
// class Newpage extends StatefulWidget {
//   const Newpage({super.key});
//
//   @override
//   State<Newpage> createState() => _NewpageState();
// }
//
// class _NewpageState extends State<Newpage> {
//   // final client = Client()
//   //     .setEndpoint('https://cloud.appwrite.io/v1')
//   //     .setProject('6474dc02a9dbd07ef9c9');
//
//   final databases = Databases(Client()
//       .setEndpoint('https://cloud.appwrite.io/v1')
//       .setProject('6474dc02a9dbd07ef9c9'));
//
//   List<dynamic>? documents;
//   bool isLoading = true;
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDocuments();
//   }
//
//   @override
//   void dispose() {
//     _titleController.dispose(); // Dispose controllers
//     _descriptionController.dispose();
//     super.dispose();
//   }
//
//   Future<void> createDocument() async {
//     try {
//       // Show dialog to get title and description
//       await showDialog<void>(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('New Document'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: _titleController,
//                   decoration: const InputDecoration(labelText: 'Title'),
//                 ),
//                 TextField(
//                   controller: _descriptionController,
//                   decoration: const InputDecoration(labelText: 'Description'),
//                 ),
//               ],
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('Cancel'),
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close dialog
//                 },
//               ),
//               TextButton(
//                 child: const Text('Create'),
//                 onPressed: () async {
//                   // Create document using the entered values
//                   final document = await databases.createDocument(
//                       databaseId: '647823736da482376f2d',
//                       collectionId: '64782384b2b62070111b',
//                       documentId: ID.unique(),
//
//                       data: {
//                         'title': _titleController.text,
//                         'description': _descriptionController.text,
//                         'createdAt': DateTime.now().toIso8601String(),
//                       });
//                   print('Document created: ${document.data}');
//
//                   _titleController.clear();
//                   _descriptionController.clear();
//
//                   Navigator.of(context).pop(); // Close the dialog
//                   fetchDocuments(); // Refresh the document list
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text('Document created successfully!')),
//                   );
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     } on AppwriteException catch (e) {
//       // ... (error handling remains the same)
//     }
//   }
//
//   Future<void> fetchDocuments() async {
//     try {
//       final response = await databases.listDocuments(
//         databaseId: '647823736da482376f2d', // Your Database ID
//         collectionId: '64782384b2b62070111b', // Your Collection ID
//       );
//       setState(() {
//         documents = response.documents;
//         isLoading = false; // Data loaded, set loading to false
//       });
//     } on AppwriteException catch (e) {
//       print('Error fetching documents: $e');
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching documents: ${e.message}')),
//       );
//     }
//   }
//
//   Future<void> deleteDocument(String documentId) async {
//     try {
//       await databases.deleteDocument(
//         databaseId: '647823736da482376f2d',
//         collectionId: '64782384b2b62070111b',
//         documentId: documentId,
//       );
//
//       print('Document deleted: $documentId');
//       fetchDocuments(); // Refresh the list after deletion
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Document deleted successfully!')),
//       );
//     } on AppwriteException catch (e) {
//       print('Error deleting document: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error deleting document: ${e.message}')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: createDocument,
//         child: Icon(Icons.arrow_circle_up_sharp),
//       ),
//       appBar: AppBar(
//         foregroundColor: Colors.white,
//         title: Text("app write",
//             style: GoogleFonts.poppins(
//               textStyle: const TextStyle(
//                 fontWeight: FontWeight.w800,
//                 color: Colors.white,
//                 fontSize: 25,
//               ),
//             )),
//         backgroundColor: const Color(0xFF1A1A1A),
//       ),
//       backgroundColor: const Color(0xFF1A1A1A),
//       body: Center(
//         child: isLoading // Show loading indicator or the list
//             ? const CircularProgressIndicator()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Circle avatar for the image
//
//                   // List of information
//
//                   // ElevatedButton(
//                   //   // Add the button
//                   //   onPressed:
//                   //       createDocument, // Call the createDocument function
//                   //   child: const Text('Create Appwrite Document'),
//                   // ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount:
//                           documents?.length ?? 0, // Handle null and empty list
//                       itemBuilder: (context, index) {
//                         final document = documents![index];
//                         final documentId = document.$id;
//                         return ListTile(
//                           title: Text(document.data['title'] ?? 'No title',
//                               style: buildTextStyle1()),
//                           subtitle: Text(document.data['description'] ?? '',
//                               style: buildTextStyle1()),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.delete, color: Colors.red),
//                             onPressed: () =>
//                                 deleteDocument(documentId), // Delete function
//                           ),
//                           // ... access other fields like this: document.data['fieldName']
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
//
//   TextStyle buildTextStyle1() {
//     return const TextStyle(
//       fontWeight: FontWeight.normal,
//       color: Colors.white,
//       fontSize: 18,
//     );
//   }
//
//   TextStyle buildTextStyle() {
//     return const TextStyle(
//       fontWeight: FontWeight.bold,
//       color: Colors.blueAccent,
//       fontSize: 22,
//     );
//   }
// }
