// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:intl/intl.dart'; // Import for date formatting
//
// class Aipage extends StatefulWidget {
//   const Aipage({super.key});
//
//   @override
//   State<Aipage> createState() => _AipageState();
// }
//
// const apiKey = 'AIzaSyCqAOl9jE9WsL4PmrulKnP3p8jODpFzcZg'; // Replace with your actual API key
//
// class _AipageState extends State<Aipage> {
//   final model = GenerativeModel(
//     model: 'gemini-1.5-flash-latest',
//     apiKey: apiKey,
//   );
//
//   List<ChatMessage> messages = [];
//   final TextEditingController _messageController = TextEditingController();
//   bool _isTyping = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initial message (optional)
//     _addMessage(ChatMessage(text: 'Hi there! How can I help you today?', isUser: false));
//   }
//
//   Future<void> _sendMessage() async {
//     if (_messageController.text.trim().isEmpty) return;
//
//     ChatMessage userMessage = ChatMessage(
//       text: _messageController.text,
//       isUser: true,
//     );
//     setState(() {
//       messages.add(userMessage);
//       _isTyping = true; // Show typing indicator
//     });
//
//     _messageController.clear();
//
//     // Generate AI response
//     final response = await model.generateContent([Content.text(userMessage.text)]);
//
//     if (response.candidates.isNotEmpty) {
//       ChatMessage aiMessage = ChatMessage(
//         text: response.candidates.first.text!,
//         isUser: false,
//       );
//       setState(() {
//         messages.add(aiMessage);
//         _isTyping = false; // Hide typing indicator
//       });
//     } else {
//       setState(() {
//         messages.add(ChatMessage(text: 'Failed to generate response.', isUser: false));
//         _isTyping = false;
//       });
//     }
//   }
//
//   void _addMessage(ChatMessage message) {
//     setState(() {
//       messages.add(message);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       backgroundColor: Colors.black,
//
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         title: const Text('AI Chat'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               reverse: true, // Show latest messages at the bottom
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[messages.length - 1 - index];
//                 return _buildMessageBubble(message);
//               },
//             ),
//           ),
//           if (_isTyping) // Show typing indicator
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'AI is typing...',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageBubble(ChatMessage message) {
//     return GestureDetector(
//       onLongPress: () {
//         Clipboard.setData(ClipboardData(text: message.text));
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Text copied to clipboard')),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
//         child: Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: message.isUser ? Colors.blue : Colors.grey[700],
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               MarkdownBody(
//                 data: message.text,
//                 styleSheet: MarkdownStyleSheet(
//                   p: TextStyle(color: message.isUser ? Colors.white : Colors.white),
//                   h1: TextStyle(
//                     color: message.isUser ? Colors.white : Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 _formatTimestamp(message.timestamp),
//                 style: TextStyle(color: message.isUser ? Colors.white70 : Colors.grey[400], fontSize: 12),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMessageInput() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.grey[800],
//         border: Border(
//           top: BorderSide(color: Colors.grey[700]!),
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               style: const TextStyle(color: Colors.white),
//               decoration: const InputDecoration(
//                 hintText: 'Type your message...',
//                 hintStyle: TextStyle(color: Colors.grey),
//                 border: InputBorder.none,
//               ),
//               onSubmitted: (text) {
//                 _sendMessage();
//               },
//             ),
//           ),
//           IconButton(
//             onPressed: _sendMessage,
//             icon: const Icon(Icons.send, color: Colors.blue),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _formatTimestamp(DateTime timestamp) {
//     final now = DateTime.now();
//     final difference = now.difference(timestamp);
//
//     if (difference.inDays > 0) {
//       return DateFormat('MMM d').format(timestamp);
//     } else if (difference.inHours > 0) {
//       return DateFormat('h:mm a').format(timestamp);
//     } else {
//       return DateFormat('h:mm a').format(timestamp);
//     }
//   }
// }
//
// class ChatMessage {
//   final String text;
//   final bool isUser;
//   final DateTime timestamp;
//
//   ChatMessage({required this.text, required this.isUser, DateTime? timestamp})
//       : timestamp = timestamp ?? DateTime.now();
// }