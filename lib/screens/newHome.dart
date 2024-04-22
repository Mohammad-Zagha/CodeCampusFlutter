import 'dart:ui' as ui;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:hive/hive.dart';
import 'package:kotlinproj/CustomWidgets/QuizCard.dart';
import 'package:kotlinproj/classes/QuizViewModel.dart';
import 'package:kotlinproj/controllers/TokenService.dart';

import 'package:kotlinproj/screens/AddExerciseSplash.dart';
import 'package:kotlinproj/screens/JoinLiveScreen.dart';
import 'package:kotlinproj/screens/Messenger.dart';
import 'package:kotlinproj/screens/ProductScreen.dart';
import 'package:kotlinproj/screens/Subscriptions.dart';
import 'package:kotlinproj/screens/addCourse.dart';
import 'package:kotlinproj/screens/MyCourses.dart';
import 'package:kotlinproj/screens/preLiveJoinScreen.dart';

import 'package:image_card/image_card.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../CustomWidgets/CourseCard.dart';
import 'package:lottie/lottie.dart';

import '../CustomWidgets/base64Image.dart';
import '../classes/CourseClass.dart';
import '../classes/TeacherClass.dart';
import '../classes/UserClass.dart';
import '../classes/UserService.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserService userService = Get.find(); // Use UserService
  final TokenService tokenService = TokenService();
  double _userRating = 4.5;

  @override
  void initState() {
    userService.fetchCourses();
    userService.fetchQuizzes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(

              children: [
                Container(height: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.greenAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                  child: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'CODE',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: ' CAMPUS',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cast_for_education_outlined,color: Colors.white,),
                          SizedBox(width: 10,),
                            Text("Education",style: TextStyle(fontFamily: 'Helvetica-rounded',color: Colors.white),)
                        ],
                      )
                    ],
                  ),),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Profile"),
                  onTap: () {
                    Get.toNamed('/profile');
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(),
                ),
                ListTile(
                  leading: Icon(Icons.subscriptions),
                  title: Text("Subscriptions"),
                  onTap: () async {
                    Future<List<Course>> courses =
                        userService.fetchSubedCourses();

                    Get.to(Subscriptions(courses: await courses));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text("Cart"),
                  onTap: () async {
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(),
                ),
                ListTile(
                  leading: Icon(Icons.library_books),
                  title: Text("Books"),
                  onTap: () async {
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(),
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text("Transactions"),
                  onTap: () async {
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 25),
              width: 250,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(35.0), // Adjust the radius as needed
                border: Border.all(
                  color: Color(0xff00E676).withOpacity(0.3),
                  width: 1.0, // Adjust the border width as needed
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(
                        0.5), // Adjust the shadow color and opacity
                    spreadRadius: 2, // Adjust the spread radius
                    blurRadius: 10, // Adjust the blur radius
                    offset: Offset(0, 3), // Adjust the offset
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      userService.teacher.value == null
                          ? userService.user.value!.email
                          : userService.teacher.value!.email,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          color: Colors.grey[500]),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AvatarGlow(
                        startDelay: const Duration(milliseconds: 1000),
                        glowColor: Colors.greenAccent,
                        glowShape: BoxShape.circle,
                        curve: Curves.fastOutSlowIn,
                        child: SizedBox(
                          width: 50.0, // Set the width of the image
                          height: 50.0, // Set the height of the image
                          child: Material(
                            elevation: 3.0,
                            shape: CircleBorder(),
                            color: Colors.transparent,
                            child: Base64ImageWidget(
                              base64String: userService.teacher.value == null
                                  ? userService.user.value!.mainImage
                                  : userService.teacher.value!.mainImage,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        userService.teacher.value == null
                            ? userService.user.value!.userName
                            : userService.teacher.value!.teacherName,
                        style: TextStyle(
                            fontFamily: 'Helvetica-rounded',
                            fontSize: 18,
                            color: Colors.grey[800]),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            tokenService.deleteToken();
                            userService.teacher.value = null;
                            userService.user.value = null;
                            Get.toNamed('/login');
                          },
                          icon: Icon(Icons.logout)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: LiquidPullToRefresh(
        onRefresh: () => userService.fetchCourses(),
        color: Colors.greenAccent[700],
        showChildOpacityTransition: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome and logout buttons
              // This part needs access to either the user or teacher name
              Obx(() {
                var isStudent = userService.user.value != null;
                var welcomeName = isStudent
                    ? userService.user.value?.userName ?? ''
                    : userService.teacher.value?.teacherName ?? '';

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                        builder: (context) => ElevatedButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: Icon(Icons.menu))),
                    Column(
                      children: [
                        Text(
                          "Welcome back",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          welcomeName,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent[
                            700], // Set the background color to white
                        shape: BoxShape
                            .circle, // Optional: Makes the container circular
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.to(Messenger());
                        },
                        icon: Icon(Icons.send),
                        color: Colors
                            .white, // Optional: Change the icon color if needed
                      ),
                    ),
                  ],
                );
              }),

              Obx(() {
                if (userService.user.value != null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () => showJoinDialog(context),
                      child: Container(
                          height: 130,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.orange, Colors.amber.shade400],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.5), // Adjust the shadow color and opacity
                                spreadRadius: 3, // Adjust the spread radius
                                blurRadius: 10, // Adjust the blur radius
                                offset: Offset(0, 2), // Adjust the offset
                              ),
                            ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.video_call_rounded,
                                  color: Colors.white,
                                  size: 75,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Join\nMeeting",
                                    style: TextStyle(
                                        fontFamily: 'Helvetica-rounded',
                                        color: Colors.white,
                                        fontSize: 30),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  );
                }
                return Container();
              }),
              Obx(() {
                if (userService.user.value != null) {
                  // Student-specific content
                  return _studentContent(userService.user.value);
                } else if (userService.teacher.value != null) {
                  // Teacher-specific content
                  return _teacherContent(userService.teacher.value);
                } else {
                  // Fallback if no user or teacher is found
                  return Center(child: Text("Please login"));
                }
              }),
              SizedBox(
                height: 5,
              ),
              Obx(() {
                if (userService.teacher.value != null) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(JoinLiveScreen());
                        },
                        child: Container(
                            width: 150,
                            height: 150,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.cyan,
                                  Colors.greenAccent.shade700
                                ],
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 75,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Start",
                                      style: TextStyle(
                                          fontFamily: 'Helvetica-rounded',
                                          color: Colors.white,
                                          fontSize: 30),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () => showJoinDialog(context),
                        child: Container(
                            width: 150,
                            height: 150,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.orange, Colors.amber.shade400],
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.video_call_rounded,
                                    color: Colors.white,
                                    size: 75,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Join",
                                      style: TextStyle(
                                          fontFamily: 'Helvetica-rounded',
                                          color: Colors.white,
                                          fontSize: 30),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              }),

              Container(
                margin: const EdgeInsets.only(left: 33, right: 33, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Explore more Courses",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                    GFButton(
                      onPressed: () {},
                      shape: GFButtonShape.pills,
                      color: const Color(0xff00E676),
                      child: const Text(
                        "View more",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                // Use Obx to listen for changes in the courses list
                List<Course> courses = userService.getCourses();
                return Container(
                  margin: EdgeInsets.only(left: 33),
                  padding: EdgeInsets.only(top: 10),
                  height: 320,
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 28),
                    scrollDirection: Axis.horizontal,
                    children: courses
                        .map((course) => CourseCard(course: course))
                        .toList(),
                    // Use map() to convert each Course object to a CourseCard widget
                  ),
                );
              }),
              Container(
                margin: const EdgeInsets.only(left: 33, right: 33, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Explore more Exercises",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                    GFButton(
                      onPressed: () {},
                      shape: GFButtonShape.pills,
                      color: const Color(0xff00E676),
                      child: const Text(
                        "View more",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                // Use Obx to listen for changes in the courses list
                List<QuizViewModel> Quizes = userService.getQuizes();
                return Container(
                  margin: EdgeInsets.only(left: 33),
                  padding: EdgeInsets.only(top: 10),
                  height: 320,
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 28),
                    scrollDirection: Axis.horizontal,
                    children: Quizes.map((quiz) => QuizCard(
                          disc: quiz.description,
                          id: quiz.id,
                          quizName: quiz.name,
                          totalMarks: quiz.totalMarks.toString(),
                          totalTime: quiz.time,
                        )).toList(),
                    // Use map() to convert each Course object to a CourseCard widget
                  ),
                );
              }),
              Container(
                margin: const EdgeInsets.only(left: 33, right: 33, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Top Teachers",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                    GFButton(
                      onPressed: () {},
                      shape: GFButtonShape.pills,
                      color: const Color(0xff00E676),
                      child: const Text(
                        "View more",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 50),
                  height: 450,
                  child: Swiper(
                    pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.grey[300], // Inactive dot color
                        activeColor: Colors.white, // Active dot color
                        space: 4.0,
                        activeSize: 10.0,
                        size: 7.0,
                      ),
                      alignment: Alignment
                          .bottomCenter, // Position pagination at the bottom
                    ),
                    itemWidth: 300.0,
                    layout: SwiperLayout.STACK,
                    loop: true,
                    autoplay: false,
                    itemBuilder: (context, index) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              "assets/por/por$index.jpg",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 90,
                            child: GFRating(
                              value: _userRating,
                              showTextForm: false,
                              suffixIcon: GFButton(
                                type: GFButtonType.transparent,
                                onPressed: () {
                                  setState(() {
                                    _userRating = 5;
                                  });
                                },
                                child: const Text('Rate'),
                              ),
                              onChanged: (double rating) {},
                              size: 22,
                              color: Colors.orange,
                              borderColor: Colors
                                  .grey, // Adjust the size to make it smaller
                              // Adjust the font size
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              child: BackdropFilter(
                                filter: ui.ImageFilter.blur(
                                    sigmaX: 4.0, sigmaY: 4.0),
                                child: Container(
                                  width: 300.0,
                                  height: 90.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.02),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Text(
                                          'AMIER', // Replace with your text
                                          style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontSize: 45.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: GFButton(
                                          onPressed: () {},
                                          color: Colors.white,
                                          type: GFButtonType.outline2x,
                                          shape: GFButtonShape.pills,
                                          child: Icon(
                                            Icons.navigate_next,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: 5,
                    viewportFraction: 0.8,
                    scale: 0.9,
                  )),
              Stack(
                children: [
                  Stack(
                    alignment: Alignment
                        .center, // Ensure the shadow and container align
                    children: <Widget>[
                      Container(
                        height: 400 + 10, // Increase size to accommodate shadow
                        width: 350 + 35, // Increase size to accommodate shadow
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Ensure shadow is visible
                          borderRadius: BorderRadius.circular(
                              20), // Rounded corners for shadow
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black87.withOpacity(
                                  0.2), // Shadow color with opacity
                              spreadRadius: 0,
                              blurRadius:
                                  10, // Adjust blur radius for desired shadow effect
                              offset: Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 400,
                        width: 380,
                        decoration: BoxDecoration(
                          // Add borderRadius to decoration
                          borderRadius: BorderRadius.circular(
                              20), // Rounded corners for the container
                          image: DecorationImage(
                            image: AssetImage("assets/coding.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 70,
                          left: 10,
                          child: Text(
                            "GET STARTED",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black.withOpacity(0.85),
                                fontSize: 13),
                          )),
                      Positioned(
                          bottom: 45,
                          left: 10,
                          child: Text(
                            "Learn to Code at any level",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                                fontSize: 19,
                                fontFamily: 'Rubik'),
                          )),
                      Positioned(
                          bottom: 25,
                          left: 10,
                          child: Text(
                            "Great coding Books for teens and grown-ups",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 13,
                                fontFamily: 'Roboto'),
                          )),
                      Positioned(
                        bottom: 25,
                        right: 10,
                        child: GFButton(
                          onPressed: () {},
                          color: Colors.black.withOpacity(0.6),
                          type: GFButtonType.outline2x,
                          shape: GFButtonShape.pills,
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 160 + 10,
                width: 400 + 10, // Increase size to accommodate shadow
                decoration: BoxDecoration(
                  color: Colors.transparent, // Ensure shadow is visible
                  borderRadius:
                      BorderRadius.circular(20), // Rounded corners for shadow
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87
                          .withOpacity(0.2), // Shadow color with opacity
                      spreadRadius: 0,
                      blurRadius:
                          10, // Adjust blur radius for desired shadow effect
                      offset: Offset(0, 3), // Shadow position
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 10, right: 20, left: 20),

                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            20.0), // Apply borderRadius here
                        child: Lottie.asset(
                          'assets/coding3.json',
                          fit: BoxFit.fill, // Stretch to fill the container
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 130,
                          child: Lottie.asset('assets/coding1.json'),
                        ),
                        SizedBox(
                          width: 130,
                          child: Lottie.asset('assets/coding2.json'),
                        )
                      ],
                    ),
                    Positioned(
                        bottom: 30,
                        left: 10,
                        child: Text(
                          "Code Blast !",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                    Positioned(
                        bottom: 15,
                        left: 10,
                        child: Row(
                          children: [
                            Container(
                              height: 18,
                              width: 28,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  "Ad",
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Code Puzzle & Brain Training",
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        )),
                    Center(
                      child: GFButton(
                          onPressed: () {},
                          color: Colors.white,
                          type: GFButtonType.outline2x,
                          shape: GFButtonShape.pills,
                          child: Text(
                            "Get",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              fontSize: 16,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Explore Our book Library!",
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w800,
                                fontSize: 18),
                          ),
                          GFButton(
                            size: 24,
                            onPressed: () {},
                            shape: GFButtonShape.pills,
                            color: const Color(0xff00E676),
                            child: const Text(
                              "View more",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.to(ProductScreen());
                },
                child: Container(
                  width: 400,
                  height: 330,
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              15.0), // Adjust the radius as needed
                          border: Border.all(
                            color: Color(0xff00E676).withOpacity(0.5),
                            width: 2.0, // Adjust the border width as needed
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(
                                  0.5), // Adjust the shadow color and opacity
                              spreadRadius: 7, // Adjust the spread radius
                              blurRadius: 10, // Adjust the blur radius
                              offset: Offset(3, 3), // Adjust the offset
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(right: 10),
                        child: TransparentImageCard(
                          width: 230,
                          height: 300,
                          imageProvider: AssetImage('assets/books/book2.jpg'),
                          tags: [
                            _tag('Best Seller', () {}),
                            _tag('books', () {}),
                            _tag('Hot', () {}),
                          ],
                          title: _title(text: "CodeQuickly", color: Colors.white),
                          description: _content(
                              text: "Card and book info", color: Colors.white),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              15.0), // Adjust the radius as needed
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
                        margin: EdgeInsets.only(right: 10),
                        child: TransparentImageCard(
                          width: 230,
                          height: 300,
                          imageProvider: AssetImage('assets/books/book1.jpg'),
                          tags: [
                            _tag('Best Seller', () {}),
                            _tag('books', () {}),
                            _tag('Hot', () {}),
                          ],
                          title: _title(text: "CodeQuickly", color: Colors.white),
                          description: _content(
                              text: "Card and book info", color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Example of a student-specific widget
  Widget _studentContent(User? user) {
    // Use 'user' to display student-specific information
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: 350,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(15.0), // Adjust the radius as needed
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: const Text(
                      "Points",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Finish an assigment to earn points",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.grey.withOpacity(0.9)),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${userService.user.value?.points}',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 36,
                                color: Colors.greenAccent),
                          ),
                          Text(
                            "Points",
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.flag,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 20),
                                Column(
                                  children: [
                                    Text(
                                      "Base Goal",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "3000",
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 18,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12),
                            child: Row(
                              children: [
                                Container(
                                  child: const Icon(
                                    Icons.local_fire_department_outlined,
                                    size: 30,
                                    color: Colors.orange,
                                  ),
                                ),
                                const SizedBox(width: 35),
                                Column(
                                  children: [
                                    Text(
                                      "Streak",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${userService.user.value?.streakLength}',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 18,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.question_mark_rounded,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 28),
                                Column(
                                  children: [
                                    Text(
                                      "Exercise",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "47",
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 18,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ), // Here
    );
    // Replace with actual content
  }

  // Example of a teacher-specific widget
  Widget _teacherContent(Teacher? teacher) {
    // Use 'teacher' to display teacher-specific information
    return Container(
        child: Container(
      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_note_outlined,
                        color: Colors.greenAccent[700],
                        size: 28,
                      )),
                  Text(
                    "Edit Course",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.to(() => AddCourse());
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.greenAccent[700],
                        size: 28,
                      )),
                  Text(
                    "Add a Course",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.to(() => AddExerciseSplash());
                      },
                      icon: Icon(
                        Icons.menu_book,
                        color: Colors.greenAccent[700],
                        size: 28,
                      )),
                  Text(
                    "Add Exercise",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.my_library_books_rounded,
                        color: Colors.greenAccent[700],
                        size: 28,
                      )),
                  Text(
                    "My books",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.greenAccent[700],
                        size: 28,
                      )),
                  Text(
                    "My cart",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.to(MyCourses());
                      },
                      icon: Icon(
                        Icons.school_outlined,
                        color: Colors.greenAccent[700],
                        size: 28,
                      )),
                  Text(
                    "My Courses",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  )
                ],
              )
            ],
          )
        ],
      ),
    )); // Replace with actual content
  }
}

Widget _title({String text = 'Card title', Color? color}) {
  return Container(
    child: Text(
      text, // Use the 'text' parameter here
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
    ),
  );
}

Widget _content({String text = 'This a card description', Color? color}) {
  return Text(
    text,
    style: TextStyle(color: color),
  );
}

Widget _footer({Color? color}) {
  return Row(
    children: [
      CircleAvatar(
        backgroundImage: AssetImage(
          'assets/avatar.png',
        ),
        radius: 12,
      ),
      const SizedBox(
        width: 4,
      ),
      Expanded(
          child: Text(
        'Super user',
        style: TextStyle(color: color),
      )),
      IconButton(onPressed: () {}, icon: Icon(Icons.share))
    ],
  );
}

Widget _tag(String tag, VoidCallback onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      margin: EdgeInsets.only(top: 60),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.green),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        tag,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

void showJoinDialog(BuildContext context) {
  final UserService userService = Get.find();
  TextEditingController idController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Join meeting'),
        content: TextField(
          controller: idController,
          decoration: InputDecoration(
            hintText: '   Enter meeting ID',
          ),
        ),
        actions: <Widget>[
          GFButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          GFButton(
            child: Text('Join'),
            onPressed: () {
              String tempUser = userService.teacher.value == null
                  ? userService.user.value!.userName
                  : userService.teacher.value!.teacherName;
              Get.to(PreLiveJoinScreen(
                  liveId: idController.text, userId: tempUser));
            },
          ),
        ],
      );
    },
  );
}
