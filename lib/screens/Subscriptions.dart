import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kotlinproj/CustomWidgets/base64Image.dart';
import '../classes/CourseClass.dart';

class Subscriptions extends StatefulWidget {
  final List<Course> courses;
  const Subscriptions({Key? key, required this.courses}) : super(key: key);

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscriptions'),
      ),
      body: ListView.builder(
        itemCount: widget.courses.length,
        itemBuilder: (context, index) {
          Course course = widget.courses[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Container(
                      height: 200,
                      child: Base64ImageWidget(base64String: course.coverImage),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: MemoryImage(base64Decode(course.mainImage)),
                    ),
                    title: Text(
                      course.courseName,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      course.description,
                      style: TextStyle(fontSize: 14),
                    ),
                    onTap: () {
                      // Handle tap on course card
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
