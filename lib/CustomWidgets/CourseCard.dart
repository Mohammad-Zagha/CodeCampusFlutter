import 'dart:convert';

import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:http/http.dart' as http;
import '../classes/CourseClass.dart';
import '../classes/UserService.dart';
import '../controllers/TokenService.dart';
import '../screens/Course.dart';
import 'base64Image.dart';

class CourseCard extends StatefulWidget {
  final Course course;
  const CourseCard({super.key, required this.course,} );

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final TokenService _tokenService = TokenService();
    return   GestureDetector(
      onTap: () async{
        String? token = await _tokenService.getToken();
        var url = Uri.http('192.168.1.102:3000', '/api/v1/User/subscribeToCourse');
        String jsonData = json.encode({
          'courseId':widget.course.id ,
          'flag':0,
        });
        var response = await http.post(
          url,
          headers: {
            "Content-Type": "application/json",
            "token": "$token"
          },
          body: jsonData
        );
        var decodedResponse = json.decode(response.body);
        print(decodedResponse);
        if (decodedResponse['message'] == 'User not subscribed' )
        {
          Get.to(()=>CourseScreen(course:widget.course,isReg: false,));
        }
        else if(decodedResponse['message'] == 'User is already subscribed to this course')
          {
            Get.to(()=>CourseScreen(course:widget.course,isReg: true,));
          }
     },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
                7.0), // Adjust the radius as needed
            border: Border.all(
              color: Color(0xff00E676).withOpacity(0.3),
              width: 1.0, // Adjust the border width as needed
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(
                    0.5), // Adjust the shadow color and opacity
                spreadRadius: 5, // Adjust the spread radius
                blurRadius: 10, // Adjust the blur radius
                offset: Offset(0, 3), // Adjust the offset
              ),
            ],
          ),
          width: 230,
          margin: const EdgeInsets.only(right: 40, left: 10),
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [

                      ],
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(30), // Set border radius
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
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                50), // Clip image with same border radius
                            child: Base64ImageWidget(
                                base64String: widget.course.mainImage)),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                 Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.course.courseName,
                    style: TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 25),
                  ),
                ),
                 Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.course.description,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                ),
                Container(
                  height: 20,
                  margin: EdgeInsets.only(left: 5),
                  child: GFRating(
                    value: widget.course.rating!.toDouble(),
                    showTextForm: false,
                    suffixIcon: GFButton(
                      type: GFButtonType.transparent,
                      onPressed: () {
                      },
                      child: const Text('Rate'),
                    ),
                    onChanged: (double rating) {},
                    size: 22,
                    color: Color(0xff00E676),
                    borderColor: Colors
                        .grey, // Adjust the size to make it smaller
                    // Adjust the font size
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only( right: 3),
                          child: const Icon(
                            Icons.access_time,
                            size: 20,
                            color: Colors.amber,
                          ),
                        ),
                         Text(
                          widget.course.creditHour.toString(),
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
                    Text('\$${widget.course.price.toString()}', style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
