import 'package:avatar_glow/avatar_glow.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kotlinproj/CustomWidgets/base64Image.dart';
import 'package:kotlinproj/screens/MyCourses.dart';
import 'package:hive/hive.dart';

import '../classes/UserService.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final UserService userService = Get.find();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.94),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Settings",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  letterSpacing: 1,
                  fontFamily: 'Helvetica-rounded'),
            ),
            SizedBox(height: 10,),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFFFAB40),
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0)), // Set your desired radius here
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AvatarGlow(
                    startDelay: const Duration(milliseconds: 1000),
                    glowColor: Colors.white,
                    glowShape: BoxShape.circle,
                    curve: Curves.fastOutSlowIn,
                    child: SizedBox(
                      width: 80.0,  // Set the width of the image
                      height: 80.0, // Set the height of the image
                      child: Material(
                        elevation: 8.0,
                        shape: CircleBorder(),
                        color: Colors.transparent,
                        child: Base64ImageWidget(
                          base64String: userService.teacher.value == null ?
                          userService.user.value!.mainImage :
                          userService.teacher.value!.mainImage,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 5,),
                  Text(
                    userService.teacher.value!=null? userService.teacher.value?.teacherName ??'':userService.user.value?.userName ??'',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        letterSpacing: 1,
                        fontFamily: 'Helvetica-rounded'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {Get.toNamed('/editprofile');},
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey[400]),
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  titleStyle:TextStyle(
                    fontFamily: 'Helvetica',fontWeight: FontWeight.w900,
                    color: Colors.grey[900]
                  ),
                  title: 'Edit Profile',
                  subtitle: "Edit how others see you",
                  subtitleStyle: TextStyle(color: Colors.grey[600]),
                ),
                SettingsItem(
                  onTap: () {Get.off(()=>MyCourses());},
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey[400]),
                  icons: Icons.school_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  titleStyle:TextStyle(
                      fontFamily: 'Helvetica',fontWeight: FontWeight.w900,
                      color: Colors.grey[900]
                  ),
                  title: 'My Courses',
                  subtitle: "See what Courses you offer and edit them",
                  subtitleStyle: TextStyle(color: Colors.grey[600]),
                ),
                SettingsItem(
                  onTap: () {},
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey[400]),
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.purple,
                  ),
                  titleStyle:TextStyle(
                      fontFamily: 'Helvetica',fontWeight: FontWeight.w900,
                      color: Colors.grey[900]
                  ),
                  title: 'About',
                  subtitle: "See what Code Cambus Offers",
                  subtitleStyle: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey[400]),
                  icons: Icons.bubble_chart,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.amber,
                  ),
                  titleStyle:TextStyle(
                      fontFamily: 'Helvetica',fontWeight: FontWeight.w900,
                      color: Colors.grey[900]
                  ),
                  title: 'Send feedback',
                  subtitle: "Talk to Us and send your feedback !",
                  subtitleStyle: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey[400]),
                  onTap: () {},
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                ),
                SettingsItem(
                  onTap: () {},
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey[400]),
                  icons: CupertinoIcons.delete_solid,
                  title: "Delete account",
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
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
