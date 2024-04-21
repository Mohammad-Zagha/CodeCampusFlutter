import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kotlinproj/CustomWidgets/ChatBubble.dart';
import 'package:kotlinproj/controllers/chat_service.dart';
import 'package:socket_io_client/socket_io_client.dart ' as IO;

import '../CustomWidgets/base64Image.dart';
import '../classes/UserService.dart';

class ChatScreen extends StatefulWidget {
  final String id,name;
  const ChatScreen({super.key, required this.id,required this.name});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final UserService userService = Get.find();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.id, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>; // Example: '2022-09-15 14:20:45'
    Timestamp timestamp = data['timestamp'];

// Convert Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();

// Add two hours to the DateTime
    DateTime dateTimePlusTwoHours = dateTime.add(Duration(hours: 2));

// Format DateTime to 'hh:mm a' format (12-hour format with AM/PM)
    String formattedTime = DateFormat('hh:mm a').format(dateTimePlusTwoHours);
    var alignment = (data['senderId'] ==
            (userService.user.value == null
                ? userService.teacher.value!.id
                : userService.user.value!.id)
        ? Alignment.centerRight
        : Alignment.centerLeft);
    var crossAxisAlignment = (data['senderId'] ==
        (userService.user.value == null
            ? userService.teacher.value!.id
            : userService.user.value!.id)
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start);
    return Container(
      padding: EdgeInsets.all(8),
      alignment: alignment,
      child: Column(
        crossAxisAlignment:crossAxisAlignment,
        children: [
          Row(
            children: [
              Text(data['senderName'],style: TextStyle(fontSize: 12,color: Colors.grey[800],fontFamily: 'Roboto'),),
              SizedBox(
                width: 40.0,  // Set the width of the image
                height: 40.0, // Set the height of the image
                child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  color: Colors.transparent,
                  child: Base64ImageWidget(
                    base64String: userService.teacher.value == null ?
                    userService.user.value!.mainImage :
                    userService.teacher.value!.mainImage,
                  ),
                ),
              ),
            ],
          ),
         ChatBubble(Message: data['message']),
          Text(formattedTime, style: TextStyle(fontSize: 12, color: Colors.grey[800], fontFamily: 'Roboto')),
        ],
      ),

    );
  }

  Widget _buildMessageList()
  {
    return StreamBuilder(stream: _chatService.getMessages(widget.id, userService.user.value == null
        ? userService.teacher.value!.id
        : userService.user.value!.id), builder: (context,snapshot){
      if(snapshot.hasError)
        {
          return Text('Error${snapshot.error}');

        }
      if(snapshot.connectionState == ConnectionState.waiting)
        {
          return Text('Lodaing Messages..');
        }
      return ListView(
        children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
      );
    });
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Divider(),
          Row(
            children: [
              Expanded(
                  child: TextField(
                controller: _messageController,
                obscureText: false,
              )),
              IconButton(
                  onPressed: sendMessage,
                  icon: Icon(
                    Icons.send,
                    size: 40,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
