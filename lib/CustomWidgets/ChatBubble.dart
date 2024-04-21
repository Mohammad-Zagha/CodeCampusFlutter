import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String Message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.Message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // More rounded corners
        color: isCurrentUser ? Colors.blue[800] : Colors.grey[300], // Colors similar to Messenger
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Text(
        Message,
        style:  TextStyle(
          fontSize: 18,
          color: isCurrentUser ?  Colors.white:Colors.black87, // Ensuring readability on darker backgrounds
        ),
      ),
    );
  }
}
