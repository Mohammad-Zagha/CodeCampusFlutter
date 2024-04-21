

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
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

      body: _buildUserList(),
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
              title:  Text(data['name']),
              onTap: (){Get.to(ChatScreen(id: data['uid'],name: data['name'],));},
            );
          }
      }
    else
      {
        if(userService.user.value!.id != data['uid'])
        {
          return ListTile(
            title: Text(data['name']),
            onTap: (){Get.to(ChatScreen(id: data['uid'],name: data['name'],));},
          );
        }
      }
    return Container();

  }
}
