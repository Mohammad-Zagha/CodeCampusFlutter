

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kotlinproj/screens/otp.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:lottie/lottie.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:mime/mime.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class TeacherInfo extends StatefulWidget {
  final  teacherSignUpInfo;
  const TeacherInfo({Key? key, required this.teacherSignUpInfo}) : super(key: key);


  @override
  _TeacherInfoState createState() => _TeacherInfoState();
}

class _TeacherInfoState extends State<TeacherInfo> {
  TextEditingController yearsController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController achievmentsController = TextEditingController();
  late Uint8List mainImage;
  late String mainMimeType;
  File? _selectedTeacherImage;
  Future<void> _pickImageFromGalleryCourse() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File _temp = File(pickedFile.path);
      setState(() {
        _selectedTeacherImage = File(pickedFile.path);

      });
      // Read the file as a byte array
      Uint8List imageBytes = await _temp.readAsBytes();
      mainImage = imageBytes;
      String? mimeType = lookupMimeType(pickedFile.path);
      mainMimeType = "$mimeType";

    }
  }

  var gender="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.greenAccent[700],
          ),
          onPressed: () {
              Get.back();
          },
        ),
        title: RichText(
          text: const TextSpan(
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
                  color: Color(0xff00E676),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 10),
              child: Text(
                "Tell us More!",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                "Let us know more about your career to help us verify your application ",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            Stack(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(2), // The border width
                        decoration: BoxDecoration(
                          color: Colors.grey, // Border color
                          shape: BoxShape.circle, // Ensures the container is circular to match the GFAvatar shape
                        ),
                        child: GFAvatar(
                          backgroundImage: _selectedTeacherImage != null
                              ? FileImage(_selectedTeacherImage!) as ImageProvider
                              : AssetImage('assets/noimage.jpg'),
                          size: 75,
                          // Other GFAvatar properties or customization can be added here
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: 220,
                    top: 135,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white, // Set the background color to white
                        shape: BoxShape.circle, // Optional: Makes the container circular
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
                        onPressed: _pickImageFromGalleryCourse,
                        icon: Icon(Icons.edit,size: 15,),
                        color: Colors.black, // Optional: Change the icon color if needed
                      ),
                    )

                ),
              ],
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: MaterialTextField(
                  controller: yearsController,
                  keyboardType: TextInputType.text,
                  hint: 'Years of experience',
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.bar_chart),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: MaterialTextField(
                  controller: ageController,
                  keyboardType: TextInputType.text,
                  hint: 'Age',
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.calendar_month),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child:
                MaterialTextField(
                  controller: nationalityController,
                  keyboardType: TextInputType.text,
                  hint: 'Nationality',
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.flag),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: MaterialTextField(
                  controller: achievmentsController,
                  keyboardType: TextInputType.text,
                  hint: 'Achievments',
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.checklist_rtl),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: EasyAutocomplete(
                    decoration: InputDecoration(
                      prefixIcon:Icon(Icons.male,color: Color(0xff00E676),),
                      label: Text("Gender"),

                    ),
                    suggestions: ['male', 'female',],
                    onChanged: (value) => gender=value,
                    onSubmitted: (value) => gender = value
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top:20),
                child: GFButton(
                  onPressed: () async {
                    String mainImageBase64 = base64Encode(mainImage);
                    int? age = int.tryParse(ageController.text); // Attempt to convert age to an integer
                    if (age == null) {
                      print('Invalid age entered');
                      // Optionally, show an error message on the UI
                      return; // Exit early if conversion fails
                    }
                    print({
                      'name': widget.teacherSignUpInfo.username,
                      'email': widget.teacherSignUpInfo.email,
                      'password': widget.teacherSignUpInfo.password,
                      'achievements':achievmentsController.text,
                      // Assuming you have fields in your TeacherInfo for nationality, experience, etc.
                      'nationality': nationalityController.text, // Replace with actual value
                      'Experience': yearsController.text, // Replace with actual value
                      'gender': gender, // Replace with actual value, might need to be collected
                      'phone': widget.teacherSignUpInfo.phoneNumber,
                      'age':age,
                      'mainMimeType':mainMimeType
                    });
                    var url = Uri.parse('http://192.168.1.102:3000/api/v1/Teacher/signUp'); // Replace with your actual endpoint
                    var response = await http.post(
                      url,
                      headers: {
                        "Content-Type": "application/json",
                      },
                      body: jsonEncode({
                        'name': widget.teacherSignUpInfo.username,
                        'email': widget.teacherSignUpInfo.email,
                        'password': widget.teacherSignUpInfo.password,
                        'achievements':achievmentsController.text,
                        // Assuming you have fields in your TeacherInfo for nationality, experience, etc.
                        'nationality': nationalityController.text, // Replace with actual value
                        'Experience': yearsController.text, // Replace with actual value
                        'gender': gender, // Replace with actual value, might need to be collected
                        'phone': widget.teacherSignUpInfo.phoneNumber,
                        'age':age,
                        'mainImage':mainImageBase64,
                        'mainMimeType':mainMimeType
                      }),
                    );

                    if (response.statusCode == 201) {
                      print(jsonDecode(response.body));

                      print('Signup successful');
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        text: 'An email has been sent to\n ${widget.teacherSignUpInfo.email}',
                        confirmBtnText: 'Enter Code',
                        cancelBtnText: 'Cancel',
                        confirmBtnColor: Colors.green,
                        onConfirmBtnTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OTP()), // Assuming OTPScreen is the name of your OTP screen widget
                          );
                        },
                      );
                      // Optionally navigate to a different screen or show a success message
                    } else {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        text: 'An Error has accoured \n Try again later !',
                        cancelBtnText: 'Done',
                        confirmBtnColor: Colors.green,
                        onConfirmBtnTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OTP()), // Assuming OTPScreen is the name of your OTP screen widget
                          );
                        },
                      );
                      // If the server did not return a 201 CREATED response,
                      print('Failed to sign up. Error: ${response.body}');
                      // Show an error message or handle accordingly
                    }
                  },

                  color: Color(0xff00E676),
                  child: Text(
                    "Finish Signing up",
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  shape: GFButtonShape.pills,
                  blockButton: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
