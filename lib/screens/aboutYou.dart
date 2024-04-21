import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:lottie/lottie.dart';
import '../CustomWidgets/RoleCards.dart';


class Aboutyou extends StatefulWidget {
  const Aboutyou({Key? key}) : super(key: key);

  @override
  _AboutyouState createState() => _AboutyouState();
}

class _AboutyouState extends State<Aboutyou> {
  bool isButtonEnabled = false;
  String selectedRole = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.greenAccent[400],
          ),
          onPressed: () {
            Get.offNamed('/login'); // Use Get.offNamed for replacement navigation
          },
        ),
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'RobotoMono',
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'CODE',
                style: TextStyle(
                  color: Colors.greenAccent[700],
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
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Container(
                child: Lottie.asset('assets/About.json'),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 60, left: 20),
              child: Text(
                "About You",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                  fontSize: 46,
                  color: Colors.black87,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      offset: Offset(1, 1),
                      blurRadius: 100,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 5, left: 20),
              child: Text(
                "We would love if you let us Know more about you ! ",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 1, left: 20),
              child: Text(
                "Choose what role Suits you ",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: RoleCards(
                onRoleSelected: (role) {
                  setState(() {
                    selectedRole = role;
                    isButtonEnabled = role.isNotEmpty;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: GFButton(
                onPressed: isButtonEnabled
                    ? () {
                  print("$selectedRole");
                  if (selectedRole == "Teacher") {
                    Get.offNamed('/signupTeacher');
                  } else {
                    Get.offNamed('/signupStudent');
                  }
                }
                    : null,
                color: Colors.greenAccent,
                type: GFButtonType.outline2x,
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                shape: GFButtonShape.pills,
              ),
            )
          ],
        ),
      ),
    );
  }
}
