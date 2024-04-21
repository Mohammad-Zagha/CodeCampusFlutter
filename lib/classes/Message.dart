import 'package:cloud_firestore/cloud_firestore.dart';

class Message
{
  final String senderId;
  final String senderName;
  final String receverId;
  final String message;
  final Timestamp timestamp;
  Message({
    required this.senderId,
    required this.senderName,
    required this.receverId,
    required this.message,
    required this.timestamp,

});
Map<String,dynamic> toMap(){
  return
      {
        'senderId':senderId,
        'senderName':senderName,
        'receverId':receverId,
        'message':message,
        'timestamp':timestamp,

      };
}
}