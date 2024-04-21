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
  final String id,name,image;
  const ChatScreen({super.key, required this.id,required this.name,required this.image});
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
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    Timestamp timestamp = data['timestamp'];
    DateTime dateTime = timestamp.toDate();
    DateTime dateTimePlusTwoHours = dateTime.add(Duration(hours: 2));
    String formattedTime = DateFormat('hh:mm a').format(dateTimePlusTwoHours);

    bool isCurrentUser = data['senderId'] == (userService.user.value?.id ?? userService.teacher.value!.id);
    Alignment messageAlignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    CrossAxisAlignment crossAxisAlignment = isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  print(data['image']);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      alignment: messageAlignment,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Container(
            width: 250,
            child: Row(
              mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (!isCurrentUser) ...[
                  _buildSenderImage(widget.image),
                  SizedBox(width: 8),
                ],
                Expanded(
                  child: ChatBubble(
                    Message: data['message'],
                    isCurrentUser: isCurrentUser,
                    // Add style modifications here if needed
                  ),
                ),
                if (isCurrentUser) ...[
                  SizedBox(width: 8),
                  _buildSenderImage(userService.teacher.value?.mainImage ?? userService.user.value!.mainImage),
                ],
              ],
            ),
          ),
          Text(formattedTime, style: TextStyle(fontSize: 12, color: Colors.grey[800], fontFamily: 'Roboto')),
        ],
      ),
    );
  }
  Widget _buildSenderImage(String base64String) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 40.0,
        height: 40.0,
        child: Material(
          elevation: 1.0,
          shape: CircleBorder(),
          color: Colors.transparent,
          child: Base64ImageWidget(base64String: base64String),
        ),
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
