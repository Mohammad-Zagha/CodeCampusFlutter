import 'package:flutter/material.dart';

class WorkoutCard extends StatelessWidget {
  final String workoutName;
  final String time;
  final String hardness;
  final int timesDone;
  final String imagePath; // New parameter to accept image path

  const WorkoutCard({
    Key? key,
    required this.workoutName,
    required this.time,
    required this.hardness,
    required this.timesDone,
    required this.imagePath, // Initialize with constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        height: 290,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(workoutName),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        // Add your favorite button logic here
                      },
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.red[300],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                height: 200,
                width: 350,
                child: Image.asset(
                  imagePath, // Use the provided image path
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.timer),
                        SizedBox(width: 5),
                        Text(time),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.sports_martial_arts_rounded),
                        SizedBox(width: 5),
                        Text(hardness),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.done_all),
                        SizedBox(width: 5),
                        Text(timesDone.toString()),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
