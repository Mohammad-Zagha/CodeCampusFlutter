import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  bool isChecked = false; // Initialize with a default value
  bool isChecked2 = false;

  String titleText1 = "I'm a";
  String roleText1 = "Teacher";
  String infoText1 = "Educating minds";

  String titleText2 = "I'm a";
  String roleText2 = "Student";
  String infoText2 = "Creating connections ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildContainer(isChecked, (value) {
              setState(() {
                isChecked = value;
                isChecked2 = !isChecked; // Uncheck the other checkbox
              });
            }, titleText1, roleText1, infoText1),
            buildContainer(isChecked2, (value) {
              setState(() {
                isChecked2 = value;
                isChecked = !isChecked2; // Uncheck the other checkbox
              });
            }, titleText2, roleText2, infoText2),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(bool isChecked, ValueChanged<bool> onChanged, String title, String role, String info) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.greenAccent[700],
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),

      width: 170,
      height: 260,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(top: 8, right: 10),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    onChanged(!isChecked);
                  },
                  child: Center(
                    child: isChecked
                        ? Icon(
                      Icons.check,
                      size: 24,
                      color: Colors.green,
                    )
                        : Icon(
                      Icons.radio_button_unchecked,
                      size: 24,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 8, top: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, top: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              role,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, top: 2),
            alignment: Alignment.centerLeft,
            child: Text(
              info,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
