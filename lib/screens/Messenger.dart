

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:kotlinproj/CustomWidgets/base64Image.dart';
import 'package:kotlinproj/screens/ChatPage.dart';
import 'package:kotlinproj/screens/ChatScreen.dart';

import '../classes/UserService.dart';

class Messenger extends StatefulWidget {
  const Messenger({super.key});

  @override
  State<Messenger> createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  final UserService userService = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.greenAccent[400],
          ),
          onPressed: () {
            Get.offNamed('/home');
          },
        ),
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'RobotoMono',
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'CODE',
                style: TextStyle(
                  color: Colors.greenAccent[700],
                ),
              ),
              TextSpan(
                text: ' CAMPUS',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: ' Messenger',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select an account to chat with',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
              ),
            ),
          ),
          Container(
              width: 350,
              child: Divider()),
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
    );
  }


  Widget _buildUserList()
  {
    return StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('users').snapshots(), builder: (context,snapshot){
      if(snapshot.hasError)
        {
          return const Text("Error");
        }
      if(snapshot.connectionState == ConnectionState.waiting)
        {
          return const Text("Loading ...");
        }
return ListView(
  children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
);
    });
  }

  Widget _buildUserListItem(DocumentSnapshot document)
  {
    Map<String,dynamic> data =document.data()! as Map<String,dynamic>;
    if(userService.user.value == null)
      {
        if(userService.teacher.value!.id != data['uid'])
          {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: MemoryImage(base64Decode(data['image'])), // Use MemoryImage for Base64 image data
              ),
              title: Text(data['name']),
              onTap: () {
                Get.to(ChatScreen(id: data['uid'], name: data['name'],image:data['image']));
              },
            );

          }
      }
    else
      {
        if(userService.user.value!.id != data['uid'])
        {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: MemoryImage(base64Decode(data['image'])), // Use MemoryImage for Base64 image data
            ),
            title: Text(data['name']),
            onTap: () {
              Get.to(ChatScreen(id: data['uid'], name: data['name'],image:data['image']));
            },
          );
        }
      }
    return Container();

  }
}
