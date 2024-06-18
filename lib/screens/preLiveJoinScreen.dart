import 'dart:math';

import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'LivePage.dart';

class PreLiveJoinScreen extends StatelessWidget {
  final String liveId, userId;

  const PreLiveJoinScreen(
      {super.key, required this.liveId, required this.userId});

  @override
  Widget build(BuildContext context) {
    final String userIdRandom = Random().nextInt(900000+100000).toString();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              height: 300,
              child: Container(
                child: Lottie.asset('assets/Meeting.json'),
              ),
            ),
            Container(
              child: Text(
                " Confirm to join the meeting",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w800,
                    fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "UserName : $userId", // username not userId
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                  fontSize: 24),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Live id  : $liveId",
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                  fontSize: 24),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {Get.back();},
                  child: Center(
                    child: Container(
                        width: 150,
                        height: 150,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red, Colors.redAccent.shade400],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Back",
                                style: TextStyle(
                                    fontFamily: 'Helvetica-rounded',
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(LivePage(
                      liveID: liveId,
                      userId: userIdRandom,
                      isHost: false,
                      name: userId,
                    ));
                  },
                  child: Center(
                    child: Container(
                        width: 150,
                        height: 150,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.cyan, Colors.greenAccent.shade700],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Join",
                                style: TextStyle(
                                    fontFamily: 'Helvetica-rounded',
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
