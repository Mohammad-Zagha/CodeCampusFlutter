import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:kotlinproj/classes/UserService.dart';
import 'package:kotlinproj/controllers/addCourseController.dart';
import 'package:kotlinproj/CustomWidgets/VideoLecturesList.dart';
import 'package:kotlinproj/screens/newHome.dart';
import 'package:lottie/lottie.dart';

class VideoUploadScreen extends StatefulWidget {
  const VideoUploadScreen({Key? key}) : super(key: key);

  @override
  State<VideoUploadScreen> createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  final AddCourseController addCourseController = Get.find();
  final UserService userService = Get.find();

  @override
  void initState() {
    super.initState();
    addCourseController.getCourseVideos(addCourseController.CurrentCourseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.greenAccent[400],
                  ),
                  onPressed: () {
                    // Navigate back
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      addCourseController.pickVideo();
                    },
                    icon: Icon(Icons.add, color: Colors.grey, size: 28),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Obx(() {
              if (addCourseController.videoLectures.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 300,
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                "Add videos By clicking "
                                '"+"'
                                " Button On the top right\n After adding a video a preview of that video will appear here ",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  color: Colors.grey[500],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await userService.fetchCourses();
                                  Get.to(Home());
                                },
                                child: Center(
                                  child: Text(
                                    "Skip for now",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline, // Add underline
                                      color: Colors.blue, // Change color as needed
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        )),
                    Center(
                      child: Container(
                        height: 400,
                        width: 350,
                        child: Lottie.asset('assets/error.json'),
                      ),
                    ),
                  ],
                );
              } else {
                return VideoLecturesList(); // Return the VideoLecturesList widget if videoLectures list is not empty
              }
            }),
          ],
        ),
      ),
    );
  }
}
