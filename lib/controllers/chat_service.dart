import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';

import '../classes/Message.dart';
import '../classes/UserService.dart';

class ChatService extends ChangeNotifier {
  final UserService userService = Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> sendMessage(String receverId, String message) async {
    final String currentUserId = userService.user.value == null
        ? userService.teacher.value!.id
        : userService.user.value!.id;
    final String currentUserName = userService.user.value == null
        ? userService.teacher.value!.teacherName
        : userService.user.value!.userName;
    final Timestamp timestamp = Timestamp.now();
    Message newMessage = Message(
        senderId: currentUserId,
        senderName: currentUserName,
        receverId: receverId,
        message: message,
        timestamp: timestamp);

    List<String> ids=[currentUserId,receverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    _firestore.collection("chat_rooms").doc(chatRoomId).collection("messages").add(newMessage.toMap());
  }


  Stream<QuerySnapshot> getMessages(String userId,String otherUserId) {
    List<String> ids = [userId,otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore.collection("chat_rooms").doc(chatRoomId).collection('messages').orderBy('timestamp',descending: false).snapshots();

  }
}
