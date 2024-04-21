import 'dart:io';
import 'dart:typed_data';

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kotlinproj/controllers/Strudent_Auth_Controller.dart';
import 'package:kotlinproj/screens/otp.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:material_text_fields/labeled_text_field.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';
import 'package:mime/mime.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'newSignup.dart';
class NewSignupStudent extends StatefulWidget {
  @override
  State<NewSignupStudent> createState() => _NewSignupStudentState();
}

class _NewSignupStudentState extends State<NewSignupStudent> {
  final StudentAuthController studentController = Get.put(
      StudentAuthController());

  bool acceptTerms = false;

  late Uint8List mainImage;
  late String mainMimeType;
  File? _selectedStudentImage;

  Future<void> _pickImageFromGalleryCourse() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File _temp = File(pickedFile.path);
      setState(() {
        _selectedStudentImage = File(pickedFile.path);

      });
      // Read the file as a byte array
      Uint8List imageBytes = await _temp.readAsBytes();
      mainImage = imageBytes;
      String? mimeType = lookupMimeType(pickedFile.path);
      mainMimeType = "$mimeType";

    }
  }

  @override
  Widget build(BuildContext context) {
    bool passwordVisible = false;
    var phoneNumber = "";
    bool acceptTerms = false;
    bool confirmPasswordVisible = false;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.greenAccent[700],
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
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
        child: Form(
          key: studentController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 15),
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800,
                              fontSize: 30),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text(
                          "As a Student",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 10,right: 20),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(2), // The border width
                              decoration: BoxDecoration(
                                color: Colors.grey, // Border color
                                shape: BoxShape.circle, // Ensures the container is circular to match the GFAvatar shape
                              ),
                              child: GFAvatar(
                                backgroundImage: _selectedStudentImage != null
                                    ? FileImage(_selectedStudentImage!) as ImageProvider
                                    : AssetImage('assets/noimage.jpg'),
                                size: 75,
                                // Other GFAvatar properties or customization can be added here
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 20,
                          top: 85,
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
                ],
              ),



              Container(
                margin: EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 5, right: 15),
                      child: LabeledTextField(
                        title: 'Login information',
                        labelSpacing: 8,
                        titleStyling: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textField: MaterialTextField(
                          keyboardType: TextInputType.text,
                          hint: 'Username',
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(Icons.text_format),
                          suffixIcon: const Icon(Icons.check),
                          controller: studentController.usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 20, right: 15),
                      child: MaterialTextField(
                        keyboardType: TextInputType.emailAddress,
                        hint: 'Email',
                        textInputAction: TextInputAction.next,
                        prefixIcon: const Icon(Icons.email_outlined),
                        suffixIcon: const Icon(Icons.check),
                        controller: studentController.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          } else if (!isValidEmail(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 20, right: 15),
                      child: MaterialTextField(
                        keyboardType: TextInputType.text,
                        hint: 'Password',
                        textInputAction: TextInputAction.done,
                        obscureText: !passwordVisible,
                        // Modified here
                        controller: studentController.passwordController,
                        theme: FilledOrOutlinedTextTheme(
                          fillColor: Colors.green.withAlpha(50),
                          radius: 12,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {

                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 8 || value.length > 20) {
                            return 'Password must be between 8 and 20 characters long';
                          } else if (!containsNumberAndSymbol(value)) {
                            return 'Password must contain symbols and numbers';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 20, right: 15),
                      child: MaterialTextField(

                        controller: studentController.confirmPasswordController,
                        keyboardType: TextInputType.text,
                        hint: 'Confirm Password',
                        textInputAction: TextInputAction.done,
                        obscureText: !confirmPasswordVisible,
                        theme: FilledOrOutlinedTextTheme(
                          fillColor: Colors.green.withAlpha(50),
                          radius: 12,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {

                          },
                        ),

                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 10, left: 20),
                      child: Text(
                        "Phone number",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 5, right: 15),
                      child: IntlPhoneField(
                        controller: studentController.phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'PS',
                        onChanged: (phone) {
                          phoneNumber = phone.completeNumber;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Phone Number is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 5, right: 15),
                child: LabeledTextField(
                  title: 'Personal information',
                  labelSpacing: 8,
                  titleStyling: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  textField: MaterialTextField(
                    keyboardType: TextInputType.text,
                    hint: 'Age',
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(Icons.text_format),
                    suffixIcon: const Icon(Icons.check),
                    controller: studentController.ageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'age is required';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: EasyAutocomplete(
                  controller: studentController.genderController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.male, color: Color(0xff00E676),),
                      label: Text("Gender"),

                    ),
                    suggestions: ['male', 'female',],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        "By clicking \"Continue\" you agree to our Terms of condition and Policies",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.grey),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: acceptTerms,
                          onChanged: (value) {

                          },
                          activeColor: Colors.greenAccent[700],

                        ),
                        GestureDetector(
                          onTap: () {

                          },
                          child: Text(
                            "Accept Terms",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1),
                child: Center(
                  child: GFButton(
                    icon: Icon(Icons.navigate_next_outlined),
                    onPressed: () async{
                      // Check if the form is valid
                      if (studentController.formKey.currentState?.validate() ?? false) {
                         await studentController.signUp(mainImage,mainMimeType);
                         if(studentController.doneStudentReg == RxBool(true))
                           {
                             QuickAlert.show(
                               context: context,
                               type: QuickAlertType.success,
                               text: 'An email has been sent to\n ${studentController.emailController.text}',
                               confirmBtnText: 'Enter Code',
                               cancelBtnText: 'Cancel',
                               confirmBtnColor: Colors.green,
                               onConfirmBtnTap: ( ) {
                                        Get.to(OTP());
                               },
                             );
                           }
                      }
                    },
                    color: Color(0xff00E676),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
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
      ),
    );
  }
}
