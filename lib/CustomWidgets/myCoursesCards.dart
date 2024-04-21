import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kotlinproj/CustomWidgets/base64Image.dart';
import 'package:kotlinproj/screens/Course.dart';
import 'package:kotlinproj/screens/CourseEditScreen.dart';

import '../classes/CourseClass.dart';
 // Import the Course class

class MyCoursesCard extends StatefulWidget {
  final Course course; // Pass the Course object as a parameter

  const MyCoursesCard({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  State<MyCoursesCard> createState() => _MyCoursesCardState();
}

class _MyCoursesCardState extends State<MyCoursesCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Get.to(CourseScreen(course: widget.course,isReg: true,));},
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,// Set border radius
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // Add shadow color
              spreadRadius: 1,
              blurRadius: 20,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), // Set border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Add shadow color
                              spreadRadius: 1,
                              blurRadius: 20,
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 80,
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(11), // Clip image with same border radius
                          child: Base64ImageWidget(base64String: widget.course.mainImage)
                        ),
                      ),
                      SizedBox(width: 10), // Add spacing between image and text
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start, // Align text to the top
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.course.courseName, // Access the courseName field of the Course object
                            style: TextStyle(
                              fontFamily: 'Helvetica-rounded',
                              color: Colors.black87,
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                widget.course.location,
                                style: TextStyle(
                                  fontFamily: 'Helvetica-rounded',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(width: 5,),

                            ],

                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(width: 15,),
                  Container(
                    margin: EdgeInsets.only(top:10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Status: ", style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black87,
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                            ),),
                            Text(widget.course.isApproved ? "Approved" : "Pending", style: TextStyle(
                              fontFamily: 'Roboto',
                              color: widget.course.isApproved ? Colors.green : Colors.lightBlueAccent,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(onPressed: (){Get.to(CourseEditScreen( course:widget.course,));}, icon: Icon(Icons.edit_outlined,size: 20,)),
                            IconButton(onPressed: (){}, icon: Icon(Icons.delete,size: 20,color: Colors.red,)),
                          ],
                        )
                      ],
                    )
                    ,
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
