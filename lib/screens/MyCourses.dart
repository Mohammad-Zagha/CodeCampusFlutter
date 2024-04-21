import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:get/get.dart';
import 'package:kotlinproj/CustomWidgets/myCoursesCards.dart';

import '../controllers/addCourseController.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  final AddCourseController addCourseController = Get.find();
  @override
  void initState() {
    super.initState();
    addCourseController.getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child:Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Courses",
                  style: TextStyle(
                      fontFamily: 'Helvetica-rounded',
                      fontWeight: FontWeight.w800,
                      fontSize: 24),
                ),
                GestureDetector(
                  onTap: (){},
                  child: Row(children: [
                    Text("+" , style: TextStyle(fontSize: 28,color: Colors.grey[500]),),
                    SizedBox(width: 5,),
                    Text("Add Course", style: TextStyle(fontSize: 18,color: Colors.grey[600]),)
                  ],),
                )
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Container(
                  height: 150,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Set border radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Add shadow color
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [Colors.green, Colors.lightGreenAccent], // Add gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,left: 10),
                        child: Row(

                          children: [
                            Icon(Icons.check_circle_outline_rounded,color: Colors.white,size: 55,),
                            SizedBox(width: 50,),
                            Text( addCourseController
                                .courses
                                .where((course) => course.isApproved)
                                .length
                                .toString() ,style: TextStyle(
                                fontFamily: 'Helvetica-rounded',
                                color:Colors.white,
                                fontWeight:  FontWeight.w800,
                                fontSize: 28
                            ),),
                          ],
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Live Courses",style: TextStyle(
                            fontFamily: 'Helvetica-rounded',
                            color:Colors.white,
                            fontWeight:  FontWeight.w800,
                            fontSize: 24
                        ),),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 25,),
                Container(
                  height: 150,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Set border radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Add shadow color
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.lightBlueAccent], // Add gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,left: 10),
                        child: Row(

                          children: [
                            Icon(Icons.admin_panel_settings_outlined,color: Colors.white,size: 55,),
                            SizedBox(width: 50,),
                            Text( addCourseController
                                .courses
                                .where((course) => course.isApproved == false)
                                .length
                                .toString(), style: TextStyle(
                                fontFamily: 'Helvetica-rounded',
                                color:Colors.white,
                                fontWeight:  FontWeight.w800,
                                fontSize: 28
                            ),),
                          ],
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Pending Courses",style: TextStyle(
                            fontFamily: 'Helvetica-rounded',
                            color:Colors.white,
                            fontWeight:  FontWeight.w800,
                            fontSize: 24
                        ),),
                      )
                    ],
                  ),
                ),

              ],
            ),
            SizedBox(height: 20,),
            Obx(() => (addCourseController.courses.length > 0)
                ? Expanded(
              child: ListView.builder(
                itemCount: addCourseController.courses.length,

                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      MyCoursesCard(course: addCourseController.courses[index]),

                      SizedBox(height: 10,),
                    ],
                  );
                },
              ),
            )
                : Container()),
          ],
        )



      ),
    );
  }
}
