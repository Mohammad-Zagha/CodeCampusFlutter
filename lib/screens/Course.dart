import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:kotlinproj/CustomWidgets/LessonCard.dart';
import 'package:kotlinproj/CustomWidgets/base64Image.dart';
import 'package:kotlinproj/classes/CourseClass.dart';
import 'package:kotlinproj/classes/UserService.dart';
import 'package:kotlinproj/screens/ChatScreen.dart';
import 'package:kotlinproj/screens/paymentScreen.dart';
import 'package:rating_summary/rating_summary.dart';

import '../CustomWidgets/CourseCard.dart';
import 'package:http/http.dart' as http;

import '../controllers/TokenService.dart';
class CourseScreen extends StatefulWidget {

  final Course course;
  final bool isReg;
  const CourseScreen({
    Key? key,
    required this.course,
    required this.isReg,
  }) : super(key: key);
  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {

  @override
  Widget build(BuildContext context) {
    final TokenService _tokenService = TokenService();
    final UserService userService = Get.find();
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
           Container(
             height: 280,
             child: Base64ImageWidget(base64String: widget.course.coverImage,),
           ),
            // Material with borderRadius and boxShadow for the Container
            Container(
              margin: EdgeInsets.only(top: 200),
              child: Material(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                elevation: 10.0, // Adjust the shadow elevation
                shadowColor: Colors.black.withOpacity(0.5), // Shadow color
                child: Container(
                // Full screen height
                  width: double.infinity, // Full screen width
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.course.courseName,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            fontFamily: 'Roboto'),
                                      ),

                                    ],
                                  ),
                                  Text(
                                    widget.course.description,
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontFamily: 'Roboto'),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: const Icon(
                                          Icons.school_outlined,
                                          size: 20,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      const Text(
                                        " 3/",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        widget.course.maximum.toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  GFButton(
                                    disabledColor: Colors.grey,
                                    onPressed: widget.isReg ?null:() async{

                                     await userService.makePayment(context,widget.course.price.toInt(),widget.course.id);

                                    },
                                    shape: GFButtonShape.pills,
                                    color: const Color(0xff00E676),
                                    child: const Text(
                                      "Join",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 6),
                                    child: Row(
                                      children: [
                                        Icon(Icons.attach_money_outlined,size: 20,color: Colors.grey[900],),
                                        Text(
                                          widget.course.price.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                              fontFamily: 'Roboto'),
                                        ),
                                    
                                      ],
                                    ),
                                  ),

                                ],
                              ),

                            ]),
                        GFRating(
                          size: 25,
                          color: Colors.greenAccent,
                          borderColor: Colors.grey,
                          value: widget.course.rating!.toDouble(),
                          onChanged: (value) {

                          },
                        ),
                        SizedBox(height: 20,),
                        Divider(),
                        Text(
                          "Lessons",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'Roboto'),
                        ),

                      Container(
                        padding: EdgeInsets.only(top: 10),
                        height: widget.isReg ? 330 : 250,
                        child: widget.isReg
                            ? ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 28),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.course.videoLectures.length,
                          itemBuilder: (context, index) {

                            final video = widget.course.videoLectures[index];
                            return LessonCard(videoLecture: video,);
                          },
                        )

                      :   Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2)
                                ),
                                width: double.infinity,
                                height: 320,

                              ),
                              Positioned(
                                  left: 35,
                                  top: 20,
                                  child: Column(
                                children: [
                                  Icon(Icons.lock_outline,size: 150, color: Colors.grey[500],),
                                  Text("You dont have premission to View this course",style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: Colors.grey[800],
                                    fontSize: 15
                                  ),)
                                ],
                              )),
                            ],
                          ),
                        ),
                        Divider(),
                        Text(
                          "Teachers",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'Roboto'),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: (){

                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10, // Adjust the size of the dot as needed
                                      height: 10, // Make sure the width and height are equal for a circle
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent[700], // The color of the dot
                                        shape: BoxShape.circle, // This makes the container a circle
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    GFAvatar(
                                      backgroundImage:
                                      AssetImage('assets/anastoma.jpg'),
                                      size: 30,
                                      // Other GFAvatar properties or customization can be added here
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      "Dr.Anas Toma",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontFamily: 'Roboto'),
                                    ),
                                    SizedBox(width: 6,),
                                    Text(
                                      "(Top 10)",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[500],
                                          fontFamily: 'Roboto'),
                                    ),
                                  ],
                                ),

                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                  width: 10, // Adjust the size of the dot as needed
                                  height: 10, // Make sure the width and height are equal for a circle
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent[700], // The color of the dot
                                    shape: BoxShape.circle, // This makes the container a circle
                                  ),
                                ),
                                SizedBox(width: 5,),
                                GFAvatar(
                                  backgroundImage:
                                  AssetImage('assets/ashrafarmoush.jpg'),
                                  size: 30,
                                  // Other GFAvatar properties or customization can be added here
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  "Dr.Ashraf Armoush",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      fontFamily: 'Roboto'),
                                ),
                                SizedBox(width: 6,),
                                Text(
                                  "(Top 10)",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[500],
                                      fontFamily: 'Roboto'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Text(
                          "Course information",
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'Roboto'),
                        ),
                        SizedBox(height: 4,),

                        Text(
                          "This Course gives you the bulding blocks of Python \nusing the skills and knowledge of the best teachers out there !",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontFamily: 'Roboto'),
                        ),
                        SizedBox(height: 4,),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(

                                  child: const Icon(
                                    Icons.school_outlined,
                                    size: 20,
                                    color: Colors.orange,
                                  ),
                                ),
                                const Text(
                                  " 3",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey),
                                ),
                                const Text(
                                  "/10",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 10,),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: const Icon(
                                    Icons.access_time,
                                    size: 20,
                                    color: Colors.amber,
                                  ),
                                ),
                                const Text(
                                  "20",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const Text(
                                  "Hr",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                            SizedBox(width: 10,),
                            Row(
                              children: [
                                Container(

                                  child: const Icon(
                                    Icons.numbers,
                                    size: 20,
                                    color: Colors.amber,
                                  ),
                                ),
                                const Text(
                                  "30",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                const Text(
                                  "Lessons (Ongoing)",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ],

                        ),//1
                              Divider(),
                        const Text(
                          "Reviews",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'Roboto'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: RatingSummary(
                            counter: 13,
                            average: 4.3,
                            counterFiveStars: 10,
                            counterFourStars: 4,
                            counterThreeStars: 2,
                            counterTwoStars: 1,
                            counterOneStars: 1,
                          ),
                        ),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row( children: [
                                  GFAvatar(
                                    backgroundImage:
                                    AssetImage('assets/manavatar.png'),
                                    size: 30,
                                    // Other GFAvatar properties or customization can be added here
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    "Mohammad Zagha",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontFamily: 'Roboto'),
                                  ),
                                ],),
                                Row(
                                  children: [
                                    GFRating(
                                      size: 18,
                                      color: Colors.amber,
                                      borderColor: Colors.grey,
                                      value: 5,
                                      onChanged: (value) {
                                      },
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      "The best Course Out there!",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontFamily: 'Roboto'),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    "This Course helped me so much in learning Python",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                              Divider(),

                              ],
                            ),
                            SizedBox(height: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row( children: [
                                  GFAvatar(
                                    backgroundImage:
                                    AssetImage('assets/persontwo.png'),
                                    size: 30,
                                    // Other GFAvatar properties or customization can be added here
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    "Abd Mahamdeh",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontFamily: 'Roboto'),
                                  ),
                                ],),
                                Row(
                                  children: [
                                    GFRating(
                                      size: 18,
                                      color: Colors.amber,
                                      borderColor: Colors.grey,
                                      value: 2,
                                      onChanged: (value) {
                                      },
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      "Not realy the best ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontFamily: 'Roboto'),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    "I tried to learn from this Course But it wasnt realy the best out there i tried my best bu meh !",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                                Divider(),

                              ],
                            )
                          ],
                        ),

                      ],

                    ),
                  ),
                  // You can add more children/widgets inside this Container
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
