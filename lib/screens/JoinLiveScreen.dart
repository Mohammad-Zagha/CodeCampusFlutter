import 'dart:math';

import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:kotlinproj/screens/LivePage.dart';

import '../classes/UserService.dart';

class JoinLiveScreen extends StatelessWidget {
  const JoinLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserService userService = Get.find();
      final String userId = Random().nextInt(900000+100000).toString();
    return Scaffold(

      body: Column(
              mainAxisAlignment: MainAxisAlignment.center,

        children: [
            SizedBox(height: 20,),
          Text("MeetingID : $userId"),
          SizedBox(height: 30,),

          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            Get.to(LivePage(liveID: userId, userId: userId,isHost: true,name: userService.teacher.value!.teacherName,));
          }, child: Text("Join"))

        ],

      ),
    );
  }
}
