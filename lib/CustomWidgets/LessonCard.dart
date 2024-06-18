import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:kotlinproj/CustomWidgets/base64Image.dart';
import 'package:kotlinproj/screens/videoScreen.dart';

import '../classes/CourseClass.dart';

class LessonCard extends StatelessWidget {
  final VideoLecture videoLecture;

  const LessonCard({Key? key, required this.videoLecture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Get.to(VideoScreen(videoUrl: videoLecture.video,));},
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(right: 40, left: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Stack(
                  children: [
                   Container(
                     height: 200,
                     child: Base64ImageWidget(base64String: videoLecture.thumbnailData,),
                   ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 25,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.black87.withOpacity(0.6),
                          ),
                          child: Center(
                            child: Text(
                              videoLecture.duration,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  elevation: 5,
                  shape: CircleBorder(),
                  child: GFAvatar(
                    backgroundImage: AssetImage('assets/anastoma.jpg'),
                    size: 30,
                  ),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      videoLecture.title,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Dr.Anas Toma",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
