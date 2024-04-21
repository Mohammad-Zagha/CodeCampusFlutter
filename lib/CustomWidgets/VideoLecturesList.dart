import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kotlinproj/CustomWidgets/base64Image.dart';
import 'package:kotlinproj/controllers/addCourseController.dart';
// Import the Course model

class VideoLecturesList extends StatelessWidget {
  final AddCourseController addCourseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          Column(
        children: addCourseController.videoLectures.map((lecture) {
          return Column(
            children: [
              Stack(
                children: [

                  Container(
                    height: 200,
                      width: 380,
                      child: Base64ImageWidget(base64String: lecture.thumbnailData)),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          12), // Adjust the radius as needed
                      child: Container(
                        height: 25,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.black87.withOpacity(0.6),
                        ),
                        child: Center(
                            child: Text(
                              lecture.duration,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.video_library),
                  title: Text(lecture.title),
                  subtitle: Text(lecture.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete,color: Colors.red,),
                    onPressed: () {
                      // Add functionality to delete the video lecture
                    },
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
