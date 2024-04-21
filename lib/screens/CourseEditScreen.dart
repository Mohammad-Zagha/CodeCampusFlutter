import 'dart:convert';
import 'dart:typed_data';

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/types/gf_toggle_type.dart';
import 'package:kotlinproj/screens/videoUploadScreen.dart';

import '../CustomWidgets/base64Image.dart';
import '../classes/CourseClass.dart';
import '../controllers/addCourseController.dart';

class CourseEditScreen extends StatefulWidget {
  final Course course; // Pass the Course object as a parameter

  const CourseEditScreen({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  State<CourseEditScreen> createState() => _CourseEditScreenState();
}

class _CourseEditScreenState extends State<CourseEditScreen> {
  final AddCourseController addCourseController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Course",
          style: TextStyle(
            fontFamily: 'Helvetica-rounded',
            fontSize: 21,
            color: Colors.grey[900],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.greenAccent[700],
          ),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(20), // Set border radius
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.grey.withOpacity(0.4), // Add shadow color
                          spreadRadius: 1,
                          blurRadius: 20,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            50), // Clip image with same border radius
                        child: Base64ImageWidget(
                            base64String: widget.course.mainImage)),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        widget.course.courseName,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        widget.course.location,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit_note_outlined,
                            size: 30,
                            color: Colors.grey[500],
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Settings",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[600]),
              )),
          SizedBox(height: 15,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.amber,
                      size: 28,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Edit course details",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.grey[900]),
                        ),
                        Text(
                          "Name ,Location ,Price ...",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    SizedBox(width: 170,),
                    Icon(Icons.arrow_forward_ios,color: Colors.grey[400]),
                  ],
                ),
                Divider(color: Colors.grey[300],)
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              addCourseController.CurrentCourseId = widget.course.id;
              Get.to(VideoUploadScreen());
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.video_collection_outlined,
                            color: Colors.amber,
                            size: 28,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Edit Videos",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.grey[900]),
                              ),
                              Text(
                                "Change video Details",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ],
                      ),


                      Icon(Icons.arrow_forward_ios,color: Colors.grey[400]),
                    ],
                  ),
                  Divider(color: Colors.grey[300],)
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.people_outline,
                          color: Colors.amber,
                          size: 28,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Manage audience",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.grey[900]),
                            ),
                            Text(
                              "Remove or block memebers",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                  color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ],
                    ),


                    Icon(Icons.arrow_forward_ios,color: Colors.grey[400]),
                  ],
                ),
                Divider(color: Colors.grey[300],)
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Course",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[600]),
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.privacy_tip_outlined,
                          color: Colors.redAccent,
                          size: 28,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Privet Course",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.grey[900]),
                            ),
                            Text(
                              "Privet Courses are only visble to the teatcher",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                  color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GFToggle(
                      onChanged: (val){},
                      value: true,
                      type: GFToggleType.ios,
                      enabledThumbColor: Colors.white,
                      enabledTrackColor: Colors.greenAccent[700],
                    )
                  ],
                ),
                Divider(color: Colors.grey[300],)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                          size: 28,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delete Course",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.grey[900]),
                            ),
                            Text(
                              "Remove and delete all course information",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                  color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,color: Colors.grey[400]),
                  ],
                ),
                Divider(color: Colors.grey[300],)
              ],
            ),
          ),
        ],
      )),
    );
  }
}
